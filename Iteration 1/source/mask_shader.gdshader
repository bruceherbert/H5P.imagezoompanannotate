shader_type canvas_item;

uniform sampler2D sprite_mask : hint_albedo;
uniform float cut_off = 0.5;
uniform vec4 rim_color : hint_color;
uniform float rim_size = 0.01;

void fragment() {
	float mask = texture(sprite_mask, UV).r;
	if (mask <= cut_off) {
		discard;
	} else if (mask < cut_off + rim_size) {
		COLOR = rim_color;
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}