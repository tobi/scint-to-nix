# frozen_string_literal: true

require "open3"
require "tempfile"

module Onix
  module Commands
    class Build
      def run(argv)
        @project = Project.new
        @ruby = ENV.fetch("RUBY", "ruby_3_4")
        @keep_going = false

        gem_path = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--gem", "-g" then gem_path = argv.shift
          when "--ruby", "-r" then @ruby = argv.shift
          when "--keep-going", "-k" then @keep_going = true
          when "--help", "-h"
            usage
            exit 0
          end
        end

        if gem_path
          build_gem_path(gem_path)
        elsif argv.size == 2
          build_app_gem(argv[0], argv[1])
        elsif argv.size == 1
          build_app(argv[0])
        else
          build_all
        end
      end

      private

      def usage
        $stderr.puts <<~USAGE
          Usage: onix build [options] [app] [gem]

          Build gem derivations via Nix.

          Examples:
            onix build                        # build every gem in the pool
            onix build fizzy                   # build all gems for an app
            onix build fizzy rack              # build a specific gem from an app
            onix build --gem nokogiri/1.19.0   # build a specific gem+version
            onix build --gem nokogiri          # build latest version

          Options:
            --gem, -g NAME[/VERSION]   Build a specific gem derivation
            --ruby, -r ATTR            Nix ruby attribute (default: ruby_3_4)
        USAGE
      end

      # ── Single gem build ─────────────────────────────────────────

      def build_gem_path(path)
        parts = path.split("/", 2)
        name = parts[0]
        gem_dir = File.join(@project.output_dir, name)

        unless Dir.exist?(gem_dir)
          abort "Unknown gem: #{name}. Not found in #{@project.output_dir}/#{name}/"
        end

        if parts[1]
          version_dir = File.join(gem_dir, parts[1])
          abort "Unknown version: #{path}" unless Dir.exist?(version_dir)
          UI.header "Build"
          UI.info "#{name} #{parts[1]}"
          exec_nix_build(version_dir)
        else
          versions = Dir.children(gem_dir)
            .select { |d| d != "default.nix" && File.directory?(File.join(gem_dir, d)) && !d.start_with?("git-") }
            .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
          abort "No versions found for #{name}" if versions.empty?
          latest = versions.last
          UI.header "Build"
          UI.info "#{name} #{latest}"
          exec_nix_build(File.join(gem_dir, latest))
        end
      end

      def exec_nix_build(derivation_dir)
        args = [
          "nix-build", "--no-out-link", derivation_dir,
          "--arg", "ruby", "(import <nixpkgs> {}).#{@ruby}",
          "--arg", "lib", "(import <nixpkgs> {}).lib",
          "--arg", "stdenv", "(import <nixpkgs> {}).stdenv",
          "--arg", "pkgs", "import <nixpkgs> {}"
        ]
        if HAS_NOM
          exec "bash", "-c", args.map { |a| shellescape(a) }.join(" ") + " 2>&1 | nom"
        else
          exec(*args)
        end
      end

      # ── App gem build ────────────────────────────────────────────

      def build_app_gem(app, gem_name)
        app_nix = File.join(@project.app_dir, "#{app}.nix")
        abort "Unknown app: #{app}" unless File.exist?(app_nix)

        UI.header "Build"
        UI.info "#{gem_name} #{UI.dim("from #{app}")}"
        exec "nix-build", "--no-out-link", "-E", <<~NIX
          let pkgs = import <nixpkgs> {};
              ruby = pkgs.#{@ruby};
              resolve = import #{@project.modules_dir}/resolve.nix;
              gems = resolve { inherit pkgs ruby; config = import #{app_nix}; };
          in gems."#{gem_name}"
        NIX
      end

      # ── App build ───────────────────────────────────────────────

      def build_app(app)
        app_nix = File.join(@project.app_dir, "#{app}.nix")
        abort "Unknown app: #{app}" unless File.exist?(app_nix)

        UI.header "Build"
        UI.info "#{app}"

        nix_build_with_progress(<<~NIX)
          let pkgs = import <nixpkgs> {};
              ruby = pkgs.#{@ruby};
              resolve = import #{@project.modules_dir}/resolve.nix;
              gems = resolve { inherit pkgs ruby; config = import #{app_nix}; };
          in builtins.attrValues gems
        NIX
      end

      # ── Build all ───────────────────────────────────────────────

      def build_all
        total = Dir.glob(File.join(@project.output_dir, "*", "*")).count { |d|
          File.directory?(d) && !File.basename(d).start_with?("git-") && File.basename(d) != "default.nix"
        }
        overlay_count = @project.overlays.size

        UI.header "Build"
        UI.info "#{total} gems #{UI.dim("(#{overlay_count} overlays)")}"

        nixexpr = Tempfile.new(["gem-build-all-", ".nix"])
        nixexpr.write(<<~NIX)
          let
            pkgs = import <nixpkgs> {};
            ruby = pkgs.#{@ruby};
            lib = pkgs.lib;
            root = #{@project.output_dir};
            dirs = builtins.attrNames (builtins.readDir root);
            versionsOf = name:
              let
                entries = builtins.readDir (root + "/\${name}");
                subdirs = lib.filterAttrs (k: v: v == "directory") entries;
              in
              map (v: pkgs.callPackage (root + "/\${name}/\${v}") { inherit ruby; })
                (builtins.attrNames subdirs);
          in
          lib.concatMap versionsOf dirs
        NIX
        nixexpr.flush

        nix_build_with_progress(nixexpr.path, is_file: true, total_hint: total)
      ensure
        nixexpr&.close
        nixexpr&.unlink
      end

      # ── Nix build with progress tracking ────────────────────────

      HAS_NOM = system("which", "nom", out: File::NULL, err: File::NULL)
      TAIL_LINES = 50

      def nix_build_with_progress(expr, is_file: false, total_hint: nil)
        nix_cmd = ["nix-build", "--no-out-link"]
        nix_cmd << "--keep-going" if @keep_going
        if is_file
          nix_cmd << expr
        else
          nix_cmd += ["-E", expr]
        end

        # Pipe through nom if available for pretty build output
        t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        output_lines = []
        failed_drvs = []
        eval_errors = []

        popen_args = if HAS_NOM
          shell_cmd = nix_cmd.map { |a| shellescape(a) }.join(" ") + " 2>&1 | nom"
          ["bash", "-c", shell_cmd]
        else
          nix_cmd
        end

        IO.popen(popen_args, err: [:child, :out]) do |io|
          io.set_encoding("UTF-8", invalid: :replace)
          io.each_line do |line|
            $stderr.print "  #{line}" if UI.tty? && !HAS_NOM
            output_lines << line
            stripped = line.strip

            case stripped
            when /error: builder for '([^']+)' failed/,
                 /error: Cannot build '([^']+)'/
              drv = $1
              name = drv_to_gem_name(drv)
              failed_drvs << { drv: drv, name: name } unless failed_drvs.any? { |f| f[:drv] == drv }

            when /attribute '([^']+)' missing/
              @_eval_missing_attr = $1

            when %r{at .*/nix/gem/([^/]+)/([^/]+)/}
              if @_eval_missing_attr
                eval_errors << "package `#{$1}` (#{$2}) depends on `pkgs.#{@_eval_missing_attr}` which doesn't exist in nixpkgs"
                @_eval_missing_attr = nil
              end

            when /^error:/
              eval_errors << stripped unless stripped == "error:"
            end
          end
        end

        exit_status = $?
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0

        # Count built derivations from nix-build stdout (store paths)
        built = output_lines.count { |l| l.strip.start_with?("/nix/store/") }
        total = total_hint || (built + failed_drvs.size)

        # Separate nom output from our summary
        $stderr.puts

        # Summary
        if !exit_status&.success? && built == 0 && failed_drvs.empty? && eval_errors.any?
          UI.fail "stopped — fix these issues before building #{UI.dim(UI.format_time(elapsed))}"
          $stderr.puts
          eval_errors.each { |e| UI.fail e }
          print_tail(output_lines)
        elsif failed_drvs.empty? && eval_errors.empty? && exit_status&.success?
          UI.done "#{built} built #{UI.dim(UI.format_time(elapsed))}"
        else
          UI.fail "#{built}/#{total} built, #{UI.red("#{failed_drvs.size} failed")} #{UI.dim(UI.format_time(elapsed))}"
          $stderr.puts
          failed_drvs.each do |f|
            overlay = File.join(@project.overlays_dir, "#{f[:name]}.nix")
            hint = File.exist?(overlay) ? "edit overlays/#{f[:name]}.nix" : "create overlays/#{f[:name]}.nix"
            nix_file = find_derivation(f[:name])
            UI.fail "#{f[:name]}  #{UI.dim("→")}  #{hint}"
            UI.step UI.dim("nix log #{f[:drv]}")
            UI.step UI.dim(nix_file) if nix_file
          end
          if failed_drvs.any?
            $stderr.puts
            overlay_doc = File.expand_path("../../../docs/overlays.md", __dir__)
            $stderr.puts "  See #{UI.dim(overlay_doc)} for how to fix build failures."
          end
          eval_errors.each { |e| UI.fail e } if eval_errors.any?
          print_tail(output_lines)
        end
      end

      def print_tail(output_lines)
        tail = output_lines.last(TAIL_LINES)
        return if tail.empty?
        $stderr.puts
        $stderr.puts UI.dim("  ── last #{tail.size} lines of nix output ──")
        tail.each { |l| $stderr.puts UI.dim("  #{l.rstrip}") }
      end

      def shellescape(s)
        return "''" if s.empty?
        s.gsub(/([^A-Za-z0-9_\-.,:\/@\n])/, '\\\\\\1')
      end

      def find_derivation(gem_name)
        gem_dir = File.join(@project.output_dir, gem_name)
        return nil unless Dir.exist?(gem_dir)
        versions = Dir.children(gem_dir)
          .select { |d| d != "default.nix" && File.directory?(File.join(gem_dir, d)) && !d.start_with?("git-") }
          .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
        return nil if versions.empty?
        File.join(gem_dir, versions.last, "default.nix")
      end

      def drv_to_gem_name(drv)
        basename = drv.sub(%r{.*/[a-z0-9]*-}, "").sub(/\.drv$/, "")
        basename.sub(/-[0-9][0-9.]*$/, "")
      end
    end
  end
end
