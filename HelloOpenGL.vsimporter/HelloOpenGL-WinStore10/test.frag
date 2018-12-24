# version 100 

precision mediump float;

uniform sampler2D tex; //this is the texture
varying vec2 fragTexCoord; //this is the texture coord

void main() {
    gl_FragColor  = texture2D(tex, fragTexCoord);
}

