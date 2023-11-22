shader_type canvas_item;
uniform bool frozen = true;

void fragment() {
	if (frozen) {
		float avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR.rgb = vec3(avg);
	}
}
