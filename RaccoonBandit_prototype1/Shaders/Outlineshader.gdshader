shader_type canvas_item;

uniform float max_line_width = 10.0;
uniform float min_line_width = 5.0;
uniform float freq = 1.0;
uniform float block_size = 20.0;
uniform vec4 outline_colour = vec4(0,0,0,1);

uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tint_factor : hint_range(0.0, 1.0) = 1.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;

const float pi = 3.1415;
const int ang_res = 16;


float hash(vec2 p, float s) {
	return fract(35.1 * sin(dot(vec3(112.3, 459.2, 753.2), vec3(p, s))));
}

float noise(vec2 p, float s) {
	vec2 d = vec2(0, 1);
	vec2 b = floor(p);
	vec2 f = fract(p);
	return mix(
		mix(hash(b + d.xx, s), hash(b + d.yx, s), f.x),
		mix(hash(b + d.xy, s), hash(b + d.yy, s), f.x), f.y);
}

float get_line_width(vec2 p, float s) {
	p /= block_size;
	float w = 0.0;
	float intensity = 1.0;
	for (int i = 0; i < 3; i++) {
		w = mix(w, noise(p, s), intensity);
		p /= 2.0;
		intensity /= 2.0;
	}
	
	return mix(max_line_width, min_line_width, w);
}

void fragment() {

	float alpha = 0.0;
	float timeStep = floor(TIME * freq);
	vec2 scale = TEXTURE_PIXEL_SIZE;
	scale *= get_line_width(UV / TEXTURE_PIXEL_SIZE, timeStep);
	for (int i = 0; i < ang_res; i++) {
		float angle = 2.0 * pi * float(i) / float(ang_res);
		vec2 disp = scale * vec2(cos(angle), sin(angle));
		alpha += texture(TEXTURE, UV + disp).a;
	}
	
	if ((alpha > 0.0) && (texture(TEXTURE, UV).a < 0.1)) {
		COLOR = outline_colour;
	}
	else {
		vec4 main_texture = texture(TEXTURE, UV);
		vec4 final_out = main_texture;
	
		float original_modulation = 1.0 - tint_factor;
	
		final_out.rgb = mix(main_texture.rgb * original_modulation, color.rgb * tint_factor, tint_factor);
		final_out.a *= fade;
	
		COLOR = final_out;
		//COLOR = texture(TEXTURE, UV);
	}
}