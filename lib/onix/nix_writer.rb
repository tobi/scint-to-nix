# frozen_string_literal: true

module Onix
  # Shared constants and helpers for writing .nix files.
  module NixWriter
    BANNER = <<~'NIX'.freeze
      #
      # ╔══════════════════════════════════════════════════════╗
      # ║  GENERATED — do not edit. Run onix generate to regen ║
      # ╚══════════════════════════════════════════════════════╝
      #
    NIX

    BANNER_IMPORT = <<~'NIX'.freeze
      #
      # ╔════════════════════════════════════════════════════╗
      # ║  GENERATED — do not edit. Run onix import to regen ║
      # ╚════════════════════════════════════════════════════╝
      #
    NIX

    # Nix heredoc indentation levels
    SH = "        "   # 8 spaces — shell commands
    HD = "    "        # 4 spaces — heredoc body / terminator
  end
end
