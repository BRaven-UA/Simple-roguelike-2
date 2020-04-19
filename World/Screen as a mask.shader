// uses screen texture as a mask to show itself
shader_type canvas_item;

void fragment(){
	vec4 screen = texture(SCREEN_TEXTURE, SCREEN_UV);
	float value = length(screen.rgb);	// accumulated pixel value
	vec4 tex = texture(TEXTURE, UV) * COLOR;
	COLOR = mix(screen, tex, step(0.001, value));	// if there is any value then adds itself to it
}