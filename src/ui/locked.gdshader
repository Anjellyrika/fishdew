shader_type canvas_item;
uniform bool locked = false;

void fragment() {
	if (locked) {
		COLOR.rgb = vec3(0.5,0.5,4);
	}
}
