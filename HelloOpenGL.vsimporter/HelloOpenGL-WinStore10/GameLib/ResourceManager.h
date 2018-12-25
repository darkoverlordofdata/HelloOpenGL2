#pragma once
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "stb/stb_image.h"
#import "Shader.h"
#import "Texture2D.h"
#import "Log.h"
/**
 * ResourceManager
 */
@interface ResourceManager : NSObject

@property (class, nonatomic) NSMutableDictionary*  Shaders;
@property (class, nonatomic) NSMutableDictionary*  Textures;

+ (Shader*)LoadShader : (NSString*)vertex withFragment : (NSString*)fragment nameAs : (NSString*)name;
+ (Shader*)LoadShader : (NSString*)path nameAs : (NSString*)name;
+ (Shader*)LoadShader : (NSString*)path;
+ (Shader*)GetShader : (NSString*)name;
+ (Texture2D*)LoadTexture: (NSString*)path alpha:(BOOL)alpha nameAs : (NSString*)name;
+ (Texture2D*)GetTexture : (NSString*)name;
+ (Shader*)loadShaderFromFile : (NSString*)vertex withFragment : (NSString*)fragment;
+ (Shader*)loadShaderFromFile : (NSString*)vertex ;
+ (Texture2D*)loadTextureFromFile: (NSString*)path alpha : (BOOL)alpha;

@end