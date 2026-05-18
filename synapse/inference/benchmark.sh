#!/usr/bin/env bash
set -euo pipefail
# Inference benchmark — test model speed and quality

MODELS="${@:-llama3.2:3b phi3:mini codellama:7b}"
PROMPT="Write a Hyprland config snippet for a laptop with touchpad gestures."

for model in $MODELS; do
  echo "=== Bench: $model ==="
  start=$(date +%s%N)
  ollama run "$model" "$PROMPT" > /dev/null 2>&1
  end=$(date +%s%N)
  elapsed=$(( (end - start) / 1000000 ))
  echo "  Response time: ${elapsed}ms"
  echo ""
done
