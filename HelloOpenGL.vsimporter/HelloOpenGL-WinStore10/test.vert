#version 100
precision mediump float;

in vec3 vert;
in vec2 vertTexCoord;
varying vec2 fragTexCoord;

void main() {
    // Pass the tex coord straight through to the fragment shader
    fragTexCoord = vertTexCoord;
    
    gl_Position = vec4(vert, 1);
}