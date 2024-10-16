shader_type canvas_item;

uniform vec4 origin: source_color;
uniform vec4 new: source_color;
uniform bool enabled = false;

uniform bool flash = false;
uniform float frequency = 20;

void fragment() {
	if (enabled){
		vec4 pixelColor = texture(TEXTURE,UV);
		if (pixelColor==origin)
		//if (pixelColor.r <=(50.0/255.0) && pixelColor.g <= (50.0/255.0) && pixelColor.b <= (50.0/255.0))
			COLOR=vec4(new.rgb,pixelColor.a >= 0.5 ? 1.0 : 0.0);

	}
	if (flash && sin(frequency * TIME)>0.0){
		vec4 pixelColor = texture(TEXTURE,UV);

		COLOR = vec4(1.0,1.0,1.0,pixelColor.a >= 0.5 ? 1.0:0.0);
	}


}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
