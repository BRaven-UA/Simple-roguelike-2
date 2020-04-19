// https://www.shadertoy.com/view/lsKSWR
shader_type canvas_item;

uniform vec4 color: hint_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float extends: hint_range(0.0, 500.0) = 100;

void fragment(){
	vec4 screen = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec2 uv = UV;
	uv *= 1.0 - uv;
	float vignette = clamp(uv.x * uv.y * extends * (sin(TIME * 5.0)*.2 + 0.6), 0.0, 1.0);
	COLOR = mix(screen, color, vignette * color.a);
}