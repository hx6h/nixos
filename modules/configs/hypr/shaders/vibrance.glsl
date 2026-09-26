#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

void main() {
    vec4 color = texture(tex, v_texcoord);

    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    color.rgb = mix(vec3(gray), color.rgb, 1.4);

    fragColor = color;
}
