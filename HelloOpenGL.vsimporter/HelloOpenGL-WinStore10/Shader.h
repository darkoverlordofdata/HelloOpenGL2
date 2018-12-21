#pragma once
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

/**
 * General purpsoe shader object. Compiles from file, generates
 * compile/link-time error messages and hosts several utility
 * functions for easy management.
 *
 * based on https://learnopengl.com/Getting-started/Shaders
 */
@interface Shader : NSObject

@property GLuint Id;

-(Shader*)Use;
-(Shader*)Compile : (NSString *)vertexSource;
-(Shader*)Compile : (NSString *)vertexSource withFragment : (NSString *)fragmentSource;
-(GLint)GetAttrib: (NSString*)name;
-(GLint)GetUniform : (NSString*)name;
-(Shader*)Set:(NSString *)name float: (GLfloat)value;
-(Shader*)Set:(NSString *)name int: (GLint)value;
-(Shader*)Set:(NSString *)name x: (GLfloat)x y: (GLfloat)y;
-(Shader*)Set:(NSString *)name vec2: (GLfloat*)value;
-(Shader*)Set:(NSString *)name x: (GLfloat)x y: (GLfloat)y z: (GLfloat)z;
-(Shader*)Set:(NSString *)name vec3: (GLfloat*)value;
-(Shader*)Set:(NSString *)name x: (GLfloat)x y: (GLfloat)y z: (GLfloat)z w: (GLfloat)w;
-(Shader*)Set:(NSString *)name vec4: (GLfloat*)value;
-(Shader*)Set:(NSString *)name matrix: (GLfloat*)matrix;

@end
