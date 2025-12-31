precision mediump float;

varying vec2 v_texcoord;
uniform sampler2D tex;

uniform vec2 resolution;

// Simple golden-ratio-based noise
float PHI = 1.6180339887498948;

highp float rand(vec2 co) {
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy, vec2(a, b));
    highp float sn = mod(dt, 3.14);
    return fract(sin(sn) * c);
}

void main() {
    vec2 uv = v_texcoord;

    // Use fixed distortion frequency and amplitude
    float distortion = 33.0; // fixed instead of time-based
    uv.x += sin(uv.y * 7.0 + distortion) * 0.005;
    uv.y += sin(uv.x * 24.0 + distortion) * 0.005;

    vec4 pixel = texture2D(tex, uv);
    gl_FragColor = pixel;
}
