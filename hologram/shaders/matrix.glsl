#version 300 es
precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

// Matrix Rain — digital rain effect (stylized)
void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    float col = 0.0;

    float speed = u_time * 2.0;
    float char_row = floor(uv.y * 40.0 + speed);
    float char_col = floor(uv.x * 80.0);

    float head = fract(char_row * 0.1 + char_col * 0.07 - speed * 0.5);
    float trail = fract(char_row * 0.05 - char_col * 0.03 - speed * 0.3);

    float brightness = head * 0.8 + trail * 0.2;
    brightness *= smoothstep(0.0, 0.3, uv.y);

    // Fake glyph: use column parity as simple character
    float glyph = step(0.5, fract(char_col * 0.17 + char_row * 0.13));

    vec3 color = vec3(0.0, brightness * (0.5 + 0.5 * glyph), 0.0);

    gl_FragColor = vec4(color, 0.25);
}
