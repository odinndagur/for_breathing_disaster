// chromatic aberration
//---------------------------------

shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float saturation = 0.0;


void fragment()
{
	vec4 col = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE), 0.0);
	float output_bw = (col.r + col.g + col.b) / 3.0;
	vec4 output_color = (1.0 - saturation) * output_bw + saturation * col;
	COLOR = vec4(output_color.r,output_color.g,output_color.b, 1.0);
}