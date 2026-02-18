# frozen_string_literal: true

require_relative "test_helper"
require "onix/pnpm/lockfile"

class PnpmLockfileParseTest < Minitest::Test
  def test_parses_simple_lockfile_v9
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "simple", "pnpm-lock.yaml"))

    assert_equal "9.0", lockfile.lockfile_version
    assert_equal 1, lockfile.importers.size
    assert_equal 15, lockfile.packages.size
    assert_equal 15, lockfile.snapshots.size
  end

  def test_parses_workspace_link_dependency
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "workspace", "pnpm-lock.yaml"))

    bar = lockfile.importers.fetch("bar")
    foo_dep = bar.dependencies.fetch("foo")

    assert_equal "link:../foo", foo_dep.version
  end

  def test_preserves_peer_suffix_variants
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "peers", "pnpm-lock.yaml"))

    snapshot_key = "foo@1.0.0(bar@2.0.0)"
    snapshot = lockfile.snapshots.fetch(snapshot_key)

    assert_equal({ "bar" => "2.0.0" }, snapshot.dependencies)
  end

  def test_snapshot_for_resolves_peer_and_name_variants
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "peers", "pnpm-lock.yaml"))
    snapshot = lockfile.snapshot_for("foo", "1.0.0(bar@2.0.0)")

    assert_equal({ "bar" => "2.0.0" }, snapshot.dependencies)
  end

  def test_snapshot_for_prefers_name_version_forms
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "peers", "pnpm-lock.yaml"))

    assert_equal ["1.0.0(bar@2.0.0)", "1.0.0", "foo@1.0.0(bar@2.0.0)", "foo@1.0.0"].uniq,
      lockfile.canonical_snapshot_keys("foo", "1.0.0(bar@2.0.0)")
  end
end
