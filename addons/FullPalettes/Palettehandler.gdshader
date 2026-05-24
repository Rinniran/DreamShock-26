shader_type canvas_item;


uniform int numberOfColors = 16;
uniform vec4 target_color_1 : source_color;
uniform vec4 target_color_2 : source_color;
uniform vec4 target_color_3 : source_color;
uniform vec4 target_color_4 : source_color;
uniform vec4 target_color_5 : source_color;
uniform vec4 target_color_6 : source_color;
uniform vec4 target_color_7 : source_color;
uniform vec4 target_color_8 : source_color;
uniform vec4 target_color_9 : source_color;
uniform vec4 target_color_10 : source_color;
uniform vec4 target_color_11 : source_color;
uniform vec4 target_color_12 : source_color;
uniform vec4 target_color_13 : source_color;
uniform vec4 target_color_14 : source_color;
uniform vec4 target_color_15 : source_color;
uniform vec4 target_color_16 : source_color;
uniform float tolerance : hint_range(0.0, 1.0) = 0.01;

void fragment() {
	vec4 referenceColors[16];
	referenceColors[0] = target_color_1;
	referenceColors[1] = target_color_2;
	referenceColors[2] = target_color_3;
	referenceColors[3] = target_color_4;
	referenceColors[4] = target_color_5;
	referenceColors[5] = target_color_6;
	referenceColors[6] = target_color_7;
	referenceColors[7] = target_color_8;
	referenceColors[8] = target_color_9;
	referenceColors[9] = target_color_10;
	referenceColors[10] = target_color_11;
	referenceColors[11] = target_color_12;
	referenceColors[12] = target_color_13;
	referenceColors[13] = target_color_14;
	referenceColors[14] = target_color_15;
	referenceColors[15] = target_color_16;
	
	vec4 textureColor = texture(TEXTURE, UV);
	COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	COLOR.rgb = referenceColors[int(floor(textureColor.r * float(numberOfColors)))].rgb;
	COLOR.a = textureColor.a;
	}