shader_type canvas_item;

uniform vec4 color: hint_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float extends: hint_range(0.0, 500.0) = 100;

void fragment(){
	vec2 uv = UV;
	uv *= 1.0 - uv;
	float aura = clamp(uv.x * uv.y * extends * (sin(TIME * 5.0)*.2 + 0.4), 0.0, 1.0);
	COLOR = vec4(color.rgb, aura * color.a);
}