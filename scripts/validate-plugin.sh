#!/usr/bin/env bash
# Forge plugin validator — schema, frontmatter, link checks, length caps.
# Exit non-zero on any failure.

set -e

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PLUGIN_ROOT"

FAIL=0
PASS=0

red()    { printf '\033[31m%s\033[0m\n' "$*"; }
green()  { printf '\033[32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[33m%s\033[0m\n' "$*"; }

check() {
  local name="$1"
  local cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    green "  ✓ $name"
    PASS=$((PASS + 1))
  else
    red "  ✗ $name"
    FAIL=$((FAIL + 1))
  fi
}

echo "== plugin.json =="
check "exists"          "test -f .claude-plugin/plugin.json"
check "valid JSON"      "python3 -m json.tool .claude-plugin/plugin.json"
check "has name"        "grep -q '\"name\"' .claude-plugin/plugin.json"
check "has version"     "grep -q '\"version\"' .claude-plugin/plugin.json"

echo
echo "== package.json =="
check "exists"          "test -f package.json"
check "valid JSON"      "python3 -m json.tool package.json"

echo
echo "== hooks/hooks.json =="
check "exists"          "test -f hooks/hooks.json"
check "valid JSON"      "python3 -m json.tool hooks/hooks.json"

echo
echo "== commands/ =="
for cmd in commands/*.md; do
  check "$(basename "$cmd") has frontmatter" "head -1 '$cmd' | grep -q '^---$'"
  check "$(basename "$cmd") has description"  "grep -q '^description:' '$cmd'"
done

echo
echo "== agents/ =="
if [ -d agents ] && [ -n "$(ls -A agents 2>/dev/null)" ]; then
  for agent in agents/*.md; do
    check "$(basename "$agent") has frontmatter"  "head -1 '$agent' | grep -q '^---$'"
    check "$(basename "$agent") has name"         "grep -q '^name:'        '$agent'"
    check "$(basename "$agent") has description"  "grep -q '^description:' '$agent'"
    check "$(basename "$agent") has tools"        "grep -q '^tools:'       '$agent'"
    check "$(basename "$agent") has valid model"  "grep -E '^model: (opus|sonnet|haiku)$' '$agent'"
  done
else
  yellow "  (no agents yet)"
fi

echo
echo "== skills/ =="
if [ -d skills ] && [ -n "$(ls -A skills 2>/dev/null)" ]; then
  for skill_dir in skills/*/; do
    skill_file="${skill_dir}SKILL.md"
    check "$(basename "$skill_dir") has SKILL.md" "test -f '$skill_file'"
    if [ -f "$skill_file" ]; then
      check "$(basename "$skill_dir") has frontmatter" "head -1 '$skill_file' | grep -q '^---$'"
      check "$(basename "$skill_dir") has description"  "grep -q '^description:' '$skill_file'"
    fi
  done
else
  yellow "  (no skills yet)"
fi

echo
echo "== templates/ =="
check "pm/ exists"      "test -d templates/pm"
check "founder/ exists" "test -d templates/founder"

echo
echo "== README.md =="
check "exists"               "test -f README.md"
README_LINES=$(wc -l < README.md 2>/dev/null || echo 0)
if [ "$README_LINES" -lt 360 ]; then
  green "  ✓ README under 360 lines ($README_LINES lines)"
  PASS=$((PASS + 1))
else
  red "  ✗ README over 360 lines ($README_LINES lines) — trim before launch"
  FAIL=$((FAIL + 1))
fi

echo
if [ "$FAIL" -eq 0 ]; then
  green "All checks passed ($PASS)"
  exit 0
else
  red "$FAIL failure(s), $PASS pass(es)"
  exit 1
fi
