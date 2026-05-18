#version 300 es
precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

// CRT Scanlines — retro monitor effect
void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    float scanline = sin(gl_FragCoord.y * 3.14159 * 2.0) * 0.1 + 0.9;
    float vignette = 1.0 - length(uv - 0.5) * 0.6;
    float flicker = 0.95 + 0.05 * sin(u_time * 3.0);
    vec3 color = vec3(0.0, 0.6, 1.0) * scanline * vignette * flicker;
    gl_FragColor = vec4(color, 0.15);
}
