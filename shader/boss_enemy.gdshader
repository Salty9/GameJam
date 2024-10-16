shader_type canvas_item;

uniform bool redEye=false;
uniform bool flash=false;
void fragment() {
	
	vec4 pixelColor = texture(TEXTURE,UV);
	
	if(flash){
		if (pixelColor.a > 0.0){
			COLOR = vec4(1.0,1.0,1.0,1.0);
		}
	}else{
		if (redEye){
			//COLOR = vec4(1.0,0.0,0.0,pixelColor.a);
			if (pixelColor.r >= 0.9 && pixelColor.g <= 0.5 && pixelColor.b<=0.5){
				COLOR = vec4(1.0,0.0,0.0,pixelColor.a);
			}
		}else{
			//COLOR = vec4(0.0,0.0,1.0,pixelColor.a);
			if (pixelColor.r >= 0.9&& pixelColor.g <= 0.5 && pixelColor.b<=0.5){
				COLOR = vec4(0.0,0.0,1.0,pixelColor.a);
			}
		}
	}
}
