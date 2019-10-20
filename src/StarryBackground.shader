shader_type canvas_item;


uniform mat4 global_transform;
uniform vec2 offset = vec2(0.0);
uniform float relative_motion = 1.0;
uniform float star_size = 1.0;

// Dave Hoskins hash functions
vec4 hash42(vec2 p)
{
	vec4 p4 = fract(vec4(p, p) * vec4(.1031, .1030, .0973, .1099));
    p4 += dot(p4, p4.wzxy+19.19);
    return fract((p4.xxyz+p4.yzzw)*p4.zywx) - 0.5;
}

vec2 hash22(vec2 p)
{
	vec3 p3 = fract(vec3(p.xy, p.x) * vec3(443.897, 441.423, 437.195));
    p3 += dot(p3, p3.yzx+19.19);
    return -1.0+2.0*fract((p3.xx+p3.yz)*p3.zy);
}

// IQ's Gradient Noise
float Gradient2D( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );
	vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( hash22( i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), 
                     dot( hash22( i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( hash22( i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), 
                     dot( hash22( i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

vec3 StarFieldLayer(vec2 p, float du, float count, float brightness, float size)
{
	vec3 hot  = vec3(181.0, 236.0, 255.0)/255.0;
	vec3 cold = vec3(255.0, 244.0, 189.0)/255.0;
	
	size *= star_size;
	
    // Tiling:
    vec2 pi;
    du *= count;    p *= count;
    pi  = floor(p); p  = fract(p)-0.5;
  
    // Randomize position, brightness and spectrum:
    vec4 h = hash42(pi);

    // Resolution independent radius:
    float s = brightness*(0.7+0.6*h.z)*smoothstep(0.8*du, -0.2*du, length(p+0.9*h.xy) - size*du);

    return s*mix(mix(vec3(1.), cold, min(1.,-2.*h.w)), hot, max(0.,2.*h.w));
}

vec3 StarField(vec2 p, float du)
{
    vec3 c;
    c  = StarFieldLayer(p, du, 25.0, 0.18, 0.5); 
    c += StarFieldLayer(p, du, 15.0, 0.25, 0.5); 
    c += StarFieldLayer(p, du, 12.0, 0.50, 0.5); 
    c += StarFieldLayer(p, du,  5.0, 1.00, 0.5); 
    c += StarFieldLayer(p, du,  3.0, 1.00, 0.9); 

    // Cluster:
    float s = 3.5*(max(0.2, Gradient2D(2.0*p*vec2(1.2,1.9)))-0.2)/(1.0-0.2);
    c += s*StarFieldLayer(p, du, 160.0, 0.10, 0.5); 
    c += s*StarFieldLayer(p, du,  80.0, 0.15, 0.5); 
    c += s*StarFieldLayer(p, du,  40.0, 0.25, 0.5); 
    c += s*StarFieldLayer(p, du,  30.0, 0.50, 0.5); 
    c += s*StarFieldLayer(p, du,  20.0, 1.00, 0.5); 
    c += s*StarFieldLayer(p, du,  10.0, 1.00, 0.9); 

    c *= 1.3;
    
    // Resolution independent brightness:
    float f = 1.0 / sqrt(660.0*du);

    return f*min(c, 1.0);
}

varying vec2 world_pos;
varying vec2 vert;
void vertex() {
	vert = VERTEX;
	world_pos = (global_transform * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec4 stars = vec4(StarField(((world_pos.xy*relative_motion)+offset)/700.0, 0.0008), 1.0);
	if( (stars.r + stars.g + stars.b)/3.0 <= 0.3 ) {
		COLOR = vec4(0.0);
	} else {
		COLOR = stars;
	}
//	COLOR = vec4(0, FRAGCOORD.x/1000.0, 0, 1);
//	COLOR = vec4(0, vert.x/1000.0, 0, 1);
//	COLOR = vec4(0, world_pos.x/1000.0, 0, 1);
//	float noise = snoise(FRAGCOORD.xy/10.0);
//	float noise = snoise(world_pos.xy/10.0);
//	float noise = star(world_pos.xy);
//	if(noise > 0.9) {
//		COLOR = vec4(1, 1, 1, 1);
//	} else {
//		COLOR = vec4(0, 0.0, 0, 0);
//	}
//	COLOR = vec4(vec3(noise), 1.0);
//	COLOR = vec4(1, 0, 0, 1.0);
}