# version 100

attribute vec4 _position;
attribute vec4 _color;
varying vec4 _outcolor;
uniform mat4 _projection;
uniform mat4 _rotate;
uniform mat4 _translate;
void main()
{
	_outcolor = _color;
	gl_Position = _projection * _translate * _rotate * _position;
}