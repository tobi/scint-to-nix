# frozen_string_literal: true

require "scint/parallel_fetcher"
require "scint/materializer"
require "scint/credentials"

module Onix
  module Commands
    class Fetch
      def run(argv)
        @project = project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i

        while argv.first&.start_with?("-")
          case argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--help", "-h"
            $stderr.puts "Usage: onix fetch [options] [packageset files...]"
            $stderr.puts "  -j, --jobs N    Parallel downloads (default: 20, env: JOBS)"
            exit 0
          end
        end

        inputs = if argv.empty?
          Dir.glob(File.join(project.packagesets_dir, "*.gem"))
        else
          argv.flat_map { |a| resolve_inputs(a) }
        end

        if inputs.empty?
          UI.fail "No packageset files found. Run 'onix import' first."
          exit 1
        end

        # Parse all lockfiles and classify specs via Materializer
        mat = project.materializer
        credentials = Scint::Credentials.new
        lockfiles = inputs.map { |f| project.parse_lockfile(f) }
        lockfiles.each { |lf| credentials.register_lockfile_sources(lf.sources) }
        all_classified = lockfiles.map { |lf| mat.classify(lf) }

        rubygems = all_classified.flat_map { |c| c[:rubygems] }.uniq { |g| "#{g[:name]}-#{g[:version]}" }
        git_repos = {}
        all_classified.each do |c|
          c[:git].each { |key, repo| git_repos[key] ||= repo }
        end
        git_gem_count = git_repos.values.sum { |r| r[:gems].size }
        path_count = all_classified.sum { |c| c[:path].size }
        total = rubygems.size + git_gem_count + path_count

        UI.header "Fetch"
        parts = ["#{rubygems.size} rubygems", "#{git_gem_count} git", "#{path_count} path"]
        UI.info "#{total} gems #{UI.dim("(#{parts.join(", ")})")}"

        # ── Git repos ─────────────────────────────────────────────────

        if git_repos.any?
          progress = UI::Progress.new(git_repos.size, label: "Git repos")
          git_repos.each_value do |repo|
            ok, error = mat.materialize_git(repo)
            unless ok
              progress.finish
              UI.fail "Failed to fetch git repo: #{repo[:uri]} @ #{repo[:rev]}"
              UI.fail error if error
              exit 1
            end
            progress.advance(success: ok)
          end
          progress.finish
        end

        # ── Rubygems (parallel fetch + materialize) ───────────────────

        if rubygems.any?
          # Filter already-materialized gems
          needed = rubygems.reject { |g| mat.materialized?(g[:name], g[:version]) }
          skipped = rubygems.size - needed.size

          if needed.empty?
            UI.done "#{rubygems.size} rubygems (all cached)"
          else
            progress = UI::Progress.new(rubygems.size, label: "Rubygems")
            skipped.times { progress.advance(skip: true) }

            fetcher = Scint::ParallelFetcher.new(
              concurrency: jobs,
              dest_dir: project.gem_cache_dir,
              credentials: credentials
            )

            items = needed.map { |g| { name: g[:name], version: g[:version], platform: g[:platform], source_uri: g[:source_uri] || "https://rubygems.org/" } }

            fetch_error = nil
            fetcher.fetch_gems(items) do |result|
              next if fetch_error # drain remaining callbacks without processing

              if result[:error]
                fetch_error = "Failed to fetch gem: #{result[:name]} #{result[:version]}\n#{result[:error]}"
              else
                # Materialize: extract source + metadata
                ok, error = mat.materialize_gem(result[:path], result[:name], result[:version])
                unless ok
                  fetch_error = "Failed to materialize gem: #{result[:name]} #{result[:version]}"
                  fetch_error += "\n#{error}" if error
                end
              end
              progress.advance(success: !fetch_error) unless fetch_error
            end

            fetcher.close
            progress.finish

            if fetch_error
              UI.fail fetch_error
              exit 1
            end
          end
        end
      end

      private

      def resolve_inputs(arg)
        if File.directory?(arg)
          Dir.glob(File.join(arg, "*.gem"))
        elsif File.file?(arg)
          [arg]
        else
          UI.warn "Not found: #{arg}"
          []
        end
      end
    end
  end
end
