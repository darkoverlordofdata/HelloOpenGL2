#version 100
//linkage between a vertex shader and a fragment shader for interpolated data
varying highp vec2 v_texcoord;
//value does not change across the primitive being processed,
//uniforms form the linkage between a shader, OpenGL ES, and the application
uniform sampler2D pixel;

void main()
{
	highp vec4 c = texture2D(pixel, vec2(v_texcoord));
	
	c.r = c.r * 0.5;
	
	gl_FragColor = c;
}
