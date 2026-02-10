# frozen_string_literal: true

module Gemset2Nix
  module Commands
    class Init
      def run(argv)
        while argv.first&.start_with?("-")
          case argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: gemset2nix init [directory]"
            $stderr.puts
            $stderr.puts "Initialize a new gemset2nix project in the given directory (default: .)"
            exit 0
          end
        end

        root = File.expand_path(argv.shift || ".")
        name = File.basename(root)

        files = {
          "cache/sources/"        => :dir,
          "cache/meta/"           => :dir,
          "cache/gems/"           => :dir,
          "cache/git-clones/"     => :dir,
          "nix/gem/"              => :dir,
          "nix/app/"              => :dir,
          "nix/modules/"          => :dir,
          "overlays/"             => :dir,
          "imports/"              => :dir,
          "cache/.gitignore"      => "gems/\ngit-clones/\n",
          "nix/modules/resolve.nix" => RESOLVE_NIX,
          "nix/modules/apps.nix"    => "{\n}\n",
        }

        created = 0
        files.each do |rel, content|
          path = File.join(root, rel)
          if content == :dir
            unless Dir.exist?(path)
              FileUtils.mkdir_p(path)
              $stderr.puts "  create #{rel}"
              created += 1
            end
          else
            unless File.exist?(path)
              FileUtils.mkdir_p(File.dirname(path))
              File.write(path, content)
              $stderr.puts "  create #{rel}"
              created += 1
            end
          end
        end

        if created == 0
          $stderr.puts "Already initialized."
        else
          $stderr.puts
          $stderr.puts "Initialized #{name}/. Now:"
          $stderr.puts
          $stderr.puts "  1. gemset2nix import #{name} path/to/Gemfile.lock"
          $stderr.puts "  2. gemset2nix fetch"
          $stderr.puts "  3. gemset2nix update"
          $stderr.puts "  4. gemset2nix build"
        end
      end

      RESOLVE_NIX = <<~'NIX'
        #
        # resolve.nix — turn a gemset (list or module-style config) into built derivations.
        #
        # Usage:
        #   resolve { inherit pkgs ruby; gemset = import ../app/fizzy.nix; }
        #   resolve { inherit pkgs ruby; gemset = { gem.app.fizzy.enable = true; }; }
        #
        {
          pkgs,
          ruby,
          gemset,
        }:
        let
          inherit (pkgs) lib stdenv;
          gems = import ./gem.nix { inherit pkgs ruby; };
          apps = import ./apps.nix;

          # Normalise: attrset (module-style) or list (legacy)
          isList = builtins.isList gemset;
          isModule = builtins.isAttrs gemset && gemset ? gem;

          # Module-style: collect enabled app gem lists + per-gem overrides
          moduleGems =
            if isModule then
              let
                appCfg = gemset.gem.app or { };
                enabledApps = lib.filterAttrs (_: v: v.enable or false) appCfg;
                appGemLists = lib.mapAttrsToList (
                  name: _:
                  if apps ? ${name} then
                    apps.${name}
                  else
                    throw "gem.app.${name}: unknown app. Available: ${builtins.concatStringsSep ", " (builtins.attrNames apps)}"
                ) enabledApps;
              in
              lib.concatLists appGemLists
            else
              [ ];

          specs = if isList then gemset else moduleGems;

          build =
            spec:
            let
              args = builtins.removeAttrs spec [ "name" ];
            in
            {
              name = spec.name;
              value = gems.${spec.name} args;
            };
        in
        builtins.listToAttrs (map build specs)
      NIX
    end
  end
end
