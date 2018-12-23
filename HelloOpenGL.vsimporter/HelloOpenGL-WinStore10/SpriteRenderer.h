#pragma once
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "tglm/tglm.h"
#import "Shader.h"
#import "Texture2D.h"


// based on https://learnopengl.com/Getting-started/Transformations

@interface SpriteRenderer : NSObject

@property GLuint Id;
@property (nonatomic) Shader* Shader;
@property GLuint VAO;
@property GLuint VBO;

-(id)initWithShader: (Shader*)shader;
-(void)InitRenderData;
-(void)Draw: (Texture2D*) texture : (Vec2)position : (Vec2)size : (GLfloat)rotate: (Vec3)color;

@end