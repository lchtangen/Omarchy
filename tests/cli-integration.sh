#!/usr/bin/env bash
# Integration tests for the om CLI
set -euo pipefail

OM_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OM="bash $OM_ROOT/src/cli/om"
PASS=0
FAIL=0

assert_ok() {
    local desc="$1"; shift
    if "$@" &>/dev/null; then
        PASS=$((PASS+1))
    else
        echo "FAIL: $desc"
        FAIL=$((FAIL+1))
    fi
}

assert_output() {
    local desc="$1" expected="$2"; shift 2
    local actual
    actual=$("$@" 2>/dev/null)
    if echo "$actual" | grep -qF "$expected"; then
        PASS=$((PASS+1))
    else
        echo "FAIL: $desc (expected '$expected' in output)"
        FAIL=$((FAIL+1))
    fi
}

assert_fail() {
    local desc="$1"; shift
    if "$@" &>/dev/null; then
        echo "FAIL: $desc (expected failure, got success)"
        FAIL=$((FAIL+1))
    else
        PASS=$((PASS+1))
    fi
}

echo "=== om CLI Integration Tests ==="

# --- om catalog ---
echo "Testing om catalog..."
assert_ok "catalog list" $OM catalog list
assert_ok "catalog list themes/colorschemes" $OM catalog list themes/colorschemes
assert_ok "catalog stats" $OM catalog stats
assert_ok "catalog search retro" $OM catalog search retro
assert_ok "catalog show aether" $OM catalog show aether
assert_ok "catalog recommend" $OM catalog recommend
assert_fail "catalog show nonexistent-xyz" $OM catalog show nonexistent-xyz
assert_fail "catalog list bogus-category" $OM catalog list bogus-category
assert_output "catalog stats shows total" "TOTAL" $OM catalog stats
assert_output "catalog search retro finds repos" "retro" $OM catalog search retro
assert_output "catalog show aether shows path" "Path" $OM catalog show aether

# --- om theme ---
echo "Testing om theme..."
assert_ok "theme list" $OM theme list
assert_ok "theme current" $OM theme current

# --- om system ---
echo "Testing om system..."
assert_ok "system info" $OM system info
assert_ok "system health" $OM system health
assert_fail "tui requires terminal" $OM tui

# --- om lab ---
echo "Testing om lab..."
assert_ok "lab ideas" $OM lab ideas
assert_ok "lab tools" $OM lab tools
assert_ok "lab tool hyprmon" $OM lab tool hyprmon
assert_ok "lab runway" $OM lab runway
assert_output "lab ideas includes theme forge" "theme-forge" $OM lab ideas
assert_output "lab tools includes hyprmon" "hyprmon" $OM lab tools

# --- om root commands ---
echo "Testing om root commands..."
assert_ok "version" $OM version
assert_ok "help" $OM help
assert_fail "unknown command" $OM boguscommand

# --- count consistency ---
echo "Testing count consistency..."
total=$(bash "$OM_ROOT/src/cli/om" catalog stats 2>/dev/null | grep "TOTAL" | awk '{print $NF}')
make_total=$(make -s status 2>/dev/null | grep "TOTAL REPOS" | awk '{print $NF}')
if [[ "$total" == "$make_total" ]]; then
    echo "  PASS: catalog total ($total) matches make status total ($make_total)"
    PASS=$((PASS+1))
else
    echo "  FAIL: catalog total ($total) != make status total ($make_total)"
    FAIL=$((FAIL+1))
fi

echo
echo "=== Results: $PASS passed, $FAIL failed ==="
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
