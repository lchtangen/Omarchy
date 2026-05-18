#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
errors=0

echo "=== Running all validators ==="

for validator in "$ROOT"/tests/validators/*.sh; do
  name=$(basename "$validator")
  [ "$name" = "run-all.sh" ] && continue
  echo "  Running $name..."
  bash "$validator" || errors=$((errors + 1))
done

echo "=== All validators complete: $errors failures ==="
exit $errors
