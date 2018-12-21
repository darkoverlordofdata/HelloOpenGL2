#import "Shader.h"

/**
 *	Shader class
 */
@implementation Shader;

/**
 * Use 
 * tell opengl to use this shader
 */
-(Shader*)Use {
	glUseProgram(self.Id);
	return self;
}

/**
 * GetAttrib
 * gets named attribute
 *
 * @param name of attribute
 * @returns value
 */
-(GLint)GetAttrib: (NSString*)name {
	return glGetAttribLocation(self.Id, [name UTF8String]);
}

/**
 * GetUniform
 * gets named uniform
 *
 * @param name of uniform
 * @returns value
 */
-(GLint)GetUniform : (NSString*)name {
	return glGetUniformLocation(self.Id, [name UTF8String]);
}


/**
 * Compile
 * load shaders from file and compile
 * If only 1 name is given, then both vertex and frragments have the same filename
 *
 * @parm source name of shader
 * @returns this shader object
 */
-(Shader*)Compile : (NSString *)vertSource {
	[self Compile:vertSource withFragment : vertSource];
	return self;
}

/**
 * Compile
 * load shaders from file and compile
 *
 * @parm source name of vertex shader
 * @parm source name of fragment shader
 * @returns this shader object
 */
-(Shader*)Compile : (NSString *)vertSource withFragment :  (NSString *)fragSource
{

	NSString* vertPath = [[NSBundle mainBundle] pathForResource:vertSource
		ofType : @"vert"];
	NSString* fragPath = [[NSBundle mainBundle] pathForResource:fragSource
		ofType : @"frag"];

	NSString* vertCode = [NSString stringWithContentsOfFile : vertPath
		encoding : NSUTF8StringEncoding
		error : NULL];
	NSString* fragCode = [NSString stringWithContentsOfFile : fragPath
		encoding : NSUTF8StringEncoding
		error : NULL];
	
	char* vertShaderPtr = [vertCode UTF8String];
	char* fragShaderPtr = [fragCode UTF8String];

	/**
	 * this doesn't work with string ptr, so create an array and copy.
	 * these are just little text files.
	 */
	char vertShader[strlen(vertShaderPtr)];
	char fragShader[strlen(fragShaderPtr)];

	memcpy(&vertShader, vertShaderPtr, strlen(vertShaderPtr));
	memcpy(&fragShader, fragShaderPtr, strlen(fragShaderPtr));
	
	GLuint vertShaderHandle = glCreateShader(GL_VERTEX_SHADER);
	GLuint fragShaderHandle = glCreateShader(GL_FRAGMENT_SHADER);

	const GLchar* vertShaderSrc[] = { vertShader };
	const GLint vertShaderLen[] = { sizeof(vertShader) };

	const GLchar* fragShaderSrc[] = { fragShader };
	const GLint fragShaderLen[] = { sizeof(fragShader) };

	glShaderSource(vertShaderHandle, 1, vertShaderSrc, vertShaderLen);
	glCompileShader(vertShaderHandle);

	glShaderSource(fragShaderHandle, 1, fragShaderSrc, fragShaderLen);
	glCompileShader(fragShaderHandle);

	self.Id = glCreateProgram();
	glAttachShader(self.Id, vertShaderHandle);
	glAttachShader(self.Id, fragShaderHandle);
	glLinkProgram(self.Id);
	glUseProgram(self.Id);

	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name float: (GLfloat)value {
	glUniform1f(glGetUniformLocation(self.Id, [name UTF8String]), value);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name int: (GLint)value {
	glUniform1i(glGetUniformLocation(self.Id, [name UTF8String]), value);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name x: (GLfloat)x y: (GLfloat)y {
	glUniform2f(glGetUniformLocation(self.Id, [name UTF8String]), x, y);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name vec2: (GLfloat*)value {
	glUniform2f(glGetUniformLocation(self.Id, [name UTF8String]), value[0], value[1]);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name x: (GLfloat)x y: (GLfloat)y z: (GLfloat)z {
	glUniform3f(glGetUniformLocation(self.Id, [name UTF8String]), x, y, z);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name vec3: (GLfloat*)value {
	glUniform3f(glGetUniformLocation(self.Id, [name UTF8String]), value[0], value[1], value[2]);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name x: (GLfloat)x y: (GLfloat)y z: (GLfloat)z w: (GLfloat)w {
	glUniform4f(glGetUniformLocation(self.Id, [name UTF8String]), x, y, z, w);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name vec4: (GLfloat*)value {
	glUniform4f(glGetUniformLocation(self.Id, [name UTF8String]), value[0], value[1], value[2], value[3]);
	return self;
}

/**
 *
 */
-(Shader*)Set : (NSString *)name matrix: (GLfloat*)matrix {
	glUniformMatrix4fv(glGetUniformLocation(self.Id, [name UTF8String]), 1, GL_FALSE, matrix);
	return self;
}

@end