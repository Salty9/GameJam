shader_type canvas_item;


void fragment() {
	vec4 pixelColor = texture(TEXTURE,UV);
	if (pixelColor.a>0.1 && pixelColor.r < 0.9  && pixelColor.b < 0.9){
		COLOR = vec4(1.0,0.3,0,pixelColor.a);
	}
}

