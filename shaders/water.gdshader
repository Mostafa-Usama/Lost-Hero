shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D texturee;
uniform float wavy : hint_range(-1, 1) = .2; 
uniform vec4 color: source_color;
void fragment() {
	vec4 x = texture(texturee, UV);
	vec4 tex = texture(TEXTURE, UV + vec2(0.091,0.091) * TIME );
	if (tex.r < .8 && tex.b < 0.8 && tex.g < .8){
		tex.a=1.0;
		tex.b = 1.0;
	}
	else{
		//x.r = .0;
		//x.g = .0;
		//x.b = 1.0;
		tex.a= .0;
	}
	vec4 screen = texture(SCREEN_TEXTURE, SCREEN_UV + wavy * tex.rr * tex.a);
	COLOR = screen * tex.r;	
	
}
 
//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
