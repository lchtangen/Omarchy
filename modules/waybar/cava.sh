#!/usr/bin/env bash
set -u
bars=(\u2581 \u2582 \u2583 \u2584 \u2585 \u2586 \u2587 \u2588)
config_file="/tmp/waybar_cava_config"
cat > "$config_file" <<EOF
[general]
bars = 18
framerate = 24
autosens = 1
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF
trap 'kill 0 2>/dev/null || true' EXIT

convert_to_bars() {
    local line="$1" IFS=';' nums out="" n
    read -ra nums <<< "$line"
    for n in "${nums[@]}"; do
        (( n < 0 || n > 7 )) && n=0
        out+="${bars[n]}"
    done
    printf '%s\n' "$out"
}

is_silence() {
    local l="${1//;/}"
    [[ -z "${l//0/}" ]]
}

pause_start=0
cava -p "$config_file" 2>/dev/null | while IFS= read -r line || [[ -n "$line" ]]; do
    if is_silence "$line"; then
        (( pause_start == 0 )) && pause_start=$SECONDS
        if (( SECONDS - pause_start >= 2 )); then echo ""
        else convert_to_bars "$line"
        fi
        continue
    fi
    pause_start=0
    convert_to_bars "$line"
done
