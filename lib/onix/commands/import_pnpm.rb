# frozen_string_literal: true

require "yaml"
require "fileutils"
require_relative "../packageset"

module Onix
  module Commands
    # `onix import-pnpm` — parse pnpm-lock.yaml and produce a hermetic JSONL packageset.
    #
    # This is the pnpm equivalent of `onix import` (which handles Gemfile.lock).
    # The output is a JSONL packageset with installer:"node" entries.
    #
    class ImportPnpm
      def run(argv)
        @project = Project.new
        name_override = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n" then name_override = argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix import-pnpm [--name NAME] <path/to/pnpm-lock.yaml>"
            exit 0
          end
        end

        if argv.empty?
          $stderr.puts "Usage: onix import-pnpm <path/to/pnpm-lock.yaml>"
          exit 1
        end

        lockfile, project_name = resolve_lockfile(argv.first, name_override)

        UI.header "Import (pnpm)"
        UI.info lockfile

        lock = YAML.safe_load(File.read(lockfile), permitted_classes: [Symbol])
        packages_section = lock["packages"] || {}
        snapshots_section = lock["snapshots"] || {}

        # ── Classify specs ───────────────────────────────────────────

        entries = []
        seen = Set.new
        git_entries = []

        # Collect world dep names (custom:* resolution) to skip
        world_dep_names = Set.new
        packages_section.each do |key, entry|
          res = entry&.dig("resolution") || {}
          if res["type"]&.start_with?("custom:")
            parsed = parse_spec(strip_peers(key))
            world_dep_names.add(parsed[:name]) if parsed
          end
        end

        if world_dep_names.any?
          UI.info "Skipping #{world_dep_names.size} world deps: #{world_dep_names.to_a.join(", ")}"
        end

        [packages_section, snapshots_section].each do |section|
          section.each do |key, entry|
            resolution = entry.is_a?(Hash) ? (entry["resolution"] || {}) : {}

            # Skip world zone dependencies
            next if resolution["type"]&.start_with?("custom:")

            clean = strip_peers(key)
            parsed = parse_spec(clean)
            next unless parsed
            next if world_dep_names.include?(parsed[:name])

            spec_key = "#{parsed[:name]}@#{parsed[:version]}"
            next if seen.include?(spec_key)
            seen.add(spec_key)

            # Git-sourced packages
            if resolution["type"] == "git" && resolution["repo"] && resolution["commit"]
              git_entries << {
                name: parsed[:name],
                version: parsed[:version],
                url: resolution["repo"],
                rev: resolution["commit"],
              }
              next
            end

            # Skip non-version specs (file:, link:, workspace:, etc.)
            next if parsed[:version].match?(/^(file:|link:|workspace:|deprecated:)/)
            next if parsed[:version].include?(":")

            # Extract metadata from packages section if available
            pkg_entry = packages_section[spec_key] || packages_section[key]
            pkg_meta = pkg_entry.is_a?(Hash) ? pkg_entry : {}

            # Detect native addon (binding.gyp, gypfile, install scripts)
            has_native = pkg_meta["hasBin"] == false && (
              pkg_meta.dig("scripts", "install")&.include?("node-gyp") ||
              pkg_meta["gypfile"] == true
            )

            # Platform constraints
            os_list = Array(pkg_meta["os"]).map(&:to_s) if pkg_meta["os"]
            cpu_list = Array(pkg_meta["cpu"]).map(&:to_s) if pkg_meta["cpu"]
            libc_list = Array(pkg_meta["libc"]).map(&:to_s) if pkg_meta["libc"]

            # Bin entries
            bin_entries = case pkg_meta["bin"]
            when String
              short_name = parsed[:name].split("/").last
              { short_name => pkg_meta["bin"] }
            when Hash
              pkg_meta["bin"]
            else
              {}
            end

            # Dependencies
            deps = []
            %w[dependencies optionalDependencies].each do |section_name|
              dep_section = pkg_meta[section_name]
              next unless dep_section.is_a?(Hash)
              deps.concat(dep_section.keys)
            end

            entries << Packageset::Entry.new(
              installer: "node",
              name: parsed[:name],
              version: parsed[:version],
              source: "npm",
              remote: "https://registry.npmjs.org",
              deps: deps.uniq,
              bin: bin_entries,
              has_native: has_native || false,
              os: os_list || [],
              cpu: cpu_list || [],
              libc: libc_list || [],
            )
          end
        end

        # ── Git-sourced packages ──────────────────────────────────────

        git_entries.each do |g|
          entries << Packageset::Entry.new(
            installer: "node",
            name: g[:name],
            version: g[:version],
            source: "git",
            uri: g[:url],
            rev: g[:rev],
          )
        end

        npm_count = entries.count { |e| e.source == "npm" }
        git_count = entries.count { |e| e.source == "git" }
        UI.info "#{npm_count} npm, #{git_count} git"

        # ── Write JSONL packageset ────────────────────────────────────

        meta = Packageset::Meta.new(
          pnpm: lock["lockfileVersion"]&.to_s,
          platforms: detect_platforms(entries),
        )

        FileUtils.mkdir_p(@project.packagesets_dir)
        outpath = File.join(@project.packagesets_dir, "#{project_name}.jsonl")
        Packageset.write(outpath, meta: meta, entries: entries)

        UI.wrote "packagesets/#{project_name}.jsonl"
        UI.done "#{entries.size} packages"
      end

      private

      def resolve_lockfile(arg, name_override)
        path = File.expand_path(arg)

        if File.directory?(path)
          lockfile = File.join(path, "pnpm-lock.yaml")
          abort "No pnpm-lock.yaml in #{path}" unless File.exist?(lockfile)
        elsif File.basename(path) == "package.json"
          lockfile = File.join(File.dirname(path), "pnpm-lock.yaml")
          abort "No pnpm-lock.yaml found next to #{path}" unless File.exist?(lockfile)
        elsif File.exist?(path)
          lockfile = path
        else
          abort "Not found: #{arg}"
        end

        project = name_override || File.basename(File.dirname(lockfile))
        [lockfile, project]
      end

      # Parse "name@version" or "@scope/name@version", stripping peer suffixes.
      def parse_spec(spec)
        return nil unless spec.include?("@")

        if spec.start_with?("@")
          idx = spec.index("@", 1)
          return nil unless idx
          name = spec[0...idx]
          version = spec[(idx + 1)..]
        else
          idx = spec.rindex("@")
          return nil unless idx && idx > 0
          name = spec[0...idx]
          version = spec[(idx + 1)..]
        end

        return nil if name.empty? || version.empty?
        { name: name, version: version }
      end

      # Strip pnpm peer dependency suffixes: "react@18.2.0(some-peer@1.0.0)" → "react@18.2.0"
      def strip_peers(spec)
        spec.sub(/\(.*\)$/, "")
      end

      # Detect platform strings from os/cpu constraints in entries
      def detect_platforms(entries)
        platforms = Set.new
        entries.each do |e|
          next if e.os.empty? && e.cpu.empty?
          e.os.each do |os|
            next if os.start_with?("!")
            e.cpu.each do |cpu|
              next if cpu.start_with?("!")
              platforms.add("#{cpu}-#{os}")
            end
            platforms.add(os) if e.cpu.empty?
          end
        end
        platforms.to_a.sort
      end
    end
  end
end
