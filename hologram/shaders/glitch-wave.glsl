#version 300 es
precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

// Glitch Wave — digital distortion wave effect
void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;

    float wave = sin(uv.y * 30.0 + u_time * 4.0) * 0.02;
    float glitch = step(0.98, fract(sin(uv.y * 100.0 + u_time * 10.0)));

    float offset = wave + glitch * 0.03;
    vec2 distorted = vec2(uv.x + offset, uv.y);

    vec3 color = vec3(
        0.0 + glitch * 0.5,
        0.3 + abs(offset) * 2.0,
        0.5 - glitch * 0.3
    );

    float scanline = sin(gl_FragCoord.y * 3.14159) * 0.5 + 0.5;
    color *= 0.8 + 0.2 * scanline;

    gl_FragColor = vec4(color, 0.2);
}
