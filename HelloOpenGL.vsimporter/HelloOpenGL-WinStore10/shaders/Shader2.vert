#version 100
//a compile-time constant, or a function parameter that is read-only
uniform mat4 modelViewProjectionMatrix;
//linkage between a vertex shader and OpenGL ES for per-vertex data
attribute vec4 position;
attribute vec2 texcoord;
//linkage between a vertex shader and a fragment shader for interpolated data
varying vec2 v_texcoord;

void main()
{
	gl_Position = position;
    v_texcoord = texcoord.xy;
}
