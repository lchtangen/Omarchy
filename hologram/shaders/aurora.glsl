#version 300 es
precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

// Aurora Borealis — northern lights ambient shader
void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    vec3 col = vec3(0.0);

    for (int i = 0; i < 5; i++) {
        float fi = float(i);
        float speed = 0.3 + fi * 0.1;
        float x = uv.x * 3.0 + u_time * speed + fi * 1.5;
        float y = uv.y * 2.0 + sin(x * 0.7 + u_time * 0.5) * 0.3;
        float band = 0.02 / abs(uv.y - y * 0.5);
        vec3 aurora_color = vec3(
            0.1 + 0.3 * sin(fi * 1.2 + u_time * 0.1),
            0.5 + 0.3 * sin(fi * 0.7 + u_time * 0.2),
            0.8 + 0.2 * sin(fi * 1.5 + u_time * 0.15)
        );
        col += aurora_color * band * 0.3;
    }

    gl_FragColor = vec4(col, 0.2);
}
