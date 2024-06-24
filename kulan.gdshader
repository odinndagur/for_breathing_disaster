shader_type spatial;

uniform sampler2D noise;
varying vec2 tex_position;

void vertex() {
	tex_position = VERTEX.xz / 2.0 + 0.5;
}

void fragment() {
	// Place fragment code here.
  NORMAL_MAP = texture(noise, tex_position).xyz;

}
