shader_type canvas_item;

uniform bool enabled=false;
uniform float frequency = 20;
void fragment() {
	if (enabled && sin(frequency * TIME) > 0.0){
		vec4 pixelColor = texture(TEXTURE,UV);

		COLOR=vec4(1.0,1.0,1.0,pixelColor.a >= 0.5 ? 1.0 : 0.0);
	}
}
