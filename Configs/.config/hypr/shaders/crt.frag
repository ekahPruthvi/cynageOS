precision mediump float;
varying vec2 v_texcoord;

uniform sampler2D tex;

void main() {
    vec2 tc = vec2(v_texcoord.x, v_texcoord.y);

    // Distance from the center
    float dx = abs(0.5 - tc.x);
    float dy = abs(0.5 - tc.y);

    // Square it to smooth the edges
    dx *= dx;
    dy *= dy;

    tc.x -= 0.5;
    tc.x *= 1.0 + (dy * 0.03);
    tc.x += 0.5;

    tc.y -= 0.5;
    tc.y *= 1.0 + (dx * 0.03);
    tc.y += 0.5;

    // Add RGB offset for retro color separation effect
    vec2 r_tc = tc + vec2(0.001, 0.0);
    vec2 g_tc = tc;
    vec2 b_tc = tc - vec2(0.001, 0.0);

    vec4 color;
    color.r = texture2D(tex, r_tc).r;
    color.g = texture2D(tex, g_tc).g;
    color.b = texture2D(tex, b_tc).b;
    color.a = 1.0;

    // Cutoff
    if (tc.y > 1.0 || tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0)
        color = vec4(0.0);

    // Apply
    gl_FragColor = color;
}
