#version 100
precision mediump float;

uniform sampler2D tex; //this is the texture
in vec2 fragTexCoord; //this is the texture coord
varying vec4 finalColor; //this is the output color of the pixel

void main() {
    finalColor = texture2D(tex, fragTexCoord);
}