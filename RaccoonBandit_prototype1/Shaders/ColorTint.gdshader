shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tint_factor : hint_range(0.0, 1.0) = 1.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 main_texture = texture(TEXTURE, UV);
	vec4 final_out = main_texture;
	
	float original_modulation = 1.0 - tint_factor;
	
	final_out.rgb = mix(main_texture.rgb * original_modulation, color.rgb * tint_factor, tint_factor);
	final_out.a *= fade;
	
	COLOR = final_out;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
