// https://stackoverflow.com/a/4712625
shader_type canvas_item;

uniform vec4 color1: hint_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color2: hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float grid_size = 800;

varying vec2 texCoord;

void vertex(){
	texCoord = VERTEX / grid_size; 
}

void fragment(){
	ivec2 size = ivec2(10, 10);
	float total = floor(texCoord.x * float(size.x)) + floor(texCoord.y * float(size.y));
	bool isEven = mod(total, 2.0) == 0.0;
	COLOR = (isEven)? color1: color2;
}