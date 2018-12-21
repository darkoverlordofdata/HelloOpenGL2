#import "Texture2D.h"

@implementation Texture2D;


/**
 * Texture2D
 *
 * @param Path of texture file *.png, etc.
 * @param Format for binding the image
 *
 */
-(Texture2D*)initWithPath:(NSString*)path : (GLuint)format {
	[self initWithPath:path imageFormat : format internalFormat : format];
	return self;
}

/**
 * Texture2D
 *
 * @param Path of texture file *.png, etc.
 * @param InternalFormat for binding the image
 * @param ImageFormat for binding the image
 *
 */
-(Texture2D*)initWithPath:(NSString*)path : (GLuint)imageFormat : (GLuint)internalFormat {
	self.Path = path;
	self.Width = 0;
	self.Height = 0;
	self.InternalFormat = internalFormat;
	self.ImageFormat = imageFormat;
	self.WrapS = GL_RGB;
	self.WrapT = GL_RGB;
	self.FilterMin = GL_LINEAR;
	self.FilterMag = GL_LINEAR;
	glGenTextures(1, &_Id);
	return self;
}

/**
 * Generate
 *
 * @param width of image to generate
 * @param height of image to generate
 * @param data bitmap data
 *
 */
-(void)Generate: (GLuint)width : (GLuint)height : (char *)data {
	self.Width = width;
	self.Height = height;
	// Create Texture
	glBindTexture(GL_TEXTURE_2D, self.Id);
	glTexImage2D(GL_TEXTURE_2D, 0, self.InternalFormat, width, height, 0, self.ImageFormat, GL_UNSIGNED_BYTE, data);
	// Set Texture wrap and filter modes
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, self.WrapS);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, self.WrapT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, self.FilterMin);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, self.FilterMag);
	// Unbind texture
	glBindTexture(GL_TEXTURE_2D, 0);

}

/**
 * Bind the texture
 */
-(void)Bind {
	glBindTexture(GL_TEXTURE_2D, self.Id);
}

@end;
