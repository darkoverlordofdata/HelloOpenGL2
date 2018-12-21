#pragma once

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "stb/stb_image.h"


/**
 * Texture2D is able to store and configure a texture in OpenGL.
 * It also hosts utility functions for easy management.
 *
 * based on https://learnopengl.com/Getting-started/Textures
 */
@interface Texture2D : NSObject

@property (assign, nonatomic) NSString *Path; // Path to the file with image data
@property GLuint Id;				// Holds the Id of the texture object, used for all 
									// texture operations to reference to particular texture
@property GLuint Width;				// Texture image dimensions
@property GLuint Height;			// Width and height of loaded image in pixels
@property GLuint InternalFormat;	// Format of texture object
@property GLuint ImageFormat;		// Format of loaded image
@property GLuint WrapS;				// Wrapping mode on S axis
@property GLuint WrapT;				// Wrapping mode on T axis
@property GLuint FilterMin;			// Filtering mode if texture pixels < screen pixels
@property GLuint FilterMag;			// Filtering mode if texture pixels > screen pixels


-(Texture2D*)initWithPath:(NSString*)path : (GLuint)format;
-(Texture2D*)initWithPath:(NSString*)path : (GLuint)imageFormat : (GLuint)internalFormat;
// Generates texture from image data
-(void)Generate: (GLuint)width : (GLuint)height : (char *) data;
// Binds the texture as the current active GL_TEXTURE_2D texture object
-(void)Bind;

@end
