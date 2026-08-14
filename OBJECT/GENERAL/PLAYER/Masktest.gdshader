shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	
	if (tex.a > 0.0)
	{
		COLOR = vec4(UV.y, 0.0, 0.5, 1.0);
	}
	else{COLOR = vec4(0.0);}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
