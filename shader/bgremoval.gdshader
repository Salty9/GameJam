shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixelColor = texture(TEXTURE,UV);
	if (abs(pixelColor.r+pixelColor.g+pixelColor.b)<=0.1){
		COLOR=vec4(pixelColor.rgb,0);
	}else{
		COLOR = pixelColor;
	}
	//COLOR = vec4(1.0,1.0,1.0,1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
