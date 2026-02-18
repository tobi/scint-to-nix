# Plan: pnpm Integration with onix

**Date**: 2026-02-13
**Archetype**: goal
**Status**: draft

## Overview

Add pnpm-lock.yaml support to onix, enabling hermetic nix derivations for npm packages. The `vsumner/feat/node-installer` branch already contains ~90% of the implementation.

### Goal

Enable onix to parse pnpm-lock.yaml files and produce hermetic nix derivations for npm packages, following the established bundler pattern.

### Problem

Node.js projects using pnpm cannot benefit from onix's hermetic nix derivations. No unified workflow for polyglot projects (Ruby + Node).

### Strategy

Complete and merge the existing `vsumner/feat/node-installer` branch rather than rebuilding from scratch.

## Task Groups

### TG1: Audit & Merge Prep

**Goal**: Verify branch is merge-ready
**Files**: Branch comparison, conflict check

**Acceptance**:
- [ ] No merge conflicts with main
- [ ] All 6 required files exist
- [ ] remix-v3 test passes
- [ ] tsdown-starter test passes

### TG2: Test Enhancement

**Goal**: Add test coverage for edge cases
**Files**: `examples/tests/`
**Depends on**: TG1

**Acceptance**:
- [ ] Scoped packages work
- [ ] Native addons build
- [ ] Platform filtering works
- [ ] Peer deps handled correctly

### TG3: Documentation

**Goal**: Update docs for Node support
**Files**: `README.md`, `docs/packageset-format.md`
**Depends on**: TG1

**Acceptance**:
- [ ] README has Node workflow
- [ ] packageset-format has Node fields
- [ ] CLI help shows both workflows

### TG4: Merge & Polish

**Goal**: Merge to main
**Depends on**: TG1, TG2, TG3

**Acceptance**:
- [ ] PR created and approved
- [ ] All tests pass
- [ ] Merged to main
- [ ] `onix import-pnpm` works

## Directives

- **MUST** maintain backward compatibility with Ruby workflow
- **MUST** validate pnpm lockfile version v9.0+
- **NEVER** mix Ruby and Node packages in same derivation
- **ALWAYS** generate sentinel file for devShell sync

## Verification

```bash
# Full verification
git checkout main
onix import-pnpm --help
cd examples/tests/remix-v3 && ./run-tests
```

---

*Task documents*: `.claudify/tasks/pnpm-onix-integration/`
