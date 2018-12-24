#pragma once
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "tglm/tglm.h"
#import "Shader.h"
#import "Texture2D.h"


// based on https://learnopengl.com/Getting-started/Transformations

typedef struct {
	float position[3];
	float texcoord[2];
} VertexData;


@interface SpriteRenderer : NSObject

@property GLuint Id;
@property (nonatomic) Shader* Shader;
@property GLint Width;
@property GLint Height;
@property GLuint VAO;
@property GLuint VBO;
@property GLuint PositionAttrib;
@property GLuint ColorAttrib;
@property GLuint ProjectionAttrib;
@property GLuint TranslateAttrib;

-(id)initWithShader: (Shader*)shader width: (int) w height: (int) h;
-(void)InitRenderData;
-(void)Draw;
//-(void)Draw: (Texture2D*) texture : (Vec2)position : (Vec2)size : (GLfloat)rotate: (Vec3)color;

@end