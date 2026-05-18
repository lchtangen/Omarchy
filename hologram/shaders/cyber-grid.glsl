#version 300 es
precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

// Cyber Grid — Holographic grid overlay shader
void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    vec2 grid = abs(fract(uv * 20.0 - vec2(u_time * 0.02)) - 0.5);
    float line = min(grid.x, grid.y);
    float glow = 1.0 - smoothstep(0.0, 0.05, line);

    vec3 color = vec3(0.0, 0.8, 1.0) * glow * 0.6;
    color += vec3(0.0, 0.4, 0.8) * glow * 0.3 * (0.5 + 0.5 * sin(u_time));

    gl_FragColor = vec4(color, 0.3);
}
