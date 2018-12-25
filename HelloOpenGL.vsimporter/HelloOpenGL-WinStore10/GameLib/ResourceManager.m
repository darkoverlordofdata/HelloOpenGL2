#import "ResourceManager.h"
/**
 * ResourceManager class
 *
 */
@implementation ResourceManager;

static NSMutableDictionary* _Shaders = nil;
static NSMutableDictionary* _Textures = nil;

+ (NSMutableDictionary*)Shaders { return _Shaders; }
+ (NSMutableDictionary*)Textures { return _Textures; }

/**
 * static constructor
 */
+ (void)load {
	_Shaders = [[NSMutableDictionary alloc] init];
	_Textures = [[NSMutableDictionary alloc] init];
}

/**
 * LoadShader
 *
 * @param vertex path to vertex shader
 * @param fragment path to fragment shader
 * @param name to cache as
 * @returns loaded, compiled and linked shader program
 */
+ (Shader*)LoadShader : (NSString*)vertex withFragment : (NSString*)fragment nameAs : (NSString*)name {
	Shader *shader = [ResourceManager loadShaderFromFile : vertex withFragment : fragment];
	[ResourceManager.Shaders setObject : shader forKey : name];
	NSLog(@"Added shader %@", name);
	return shader;
}

/**
 * LoadShader
 *
 * @param vertex path to vertex shader
 * @param name to cache as
 * @returns loaded, compiled and linked shader program
 */
+ (Shader*)LoadShader : (NSString*)path nameAs : (NSString*)name {
	return [ResourceManager LoadShader : path withFragment : path nameAs : name];
}

/**
 * LoadShader
 *
 * @param vertex path to vertex shader
 * @returns loaded, compiled and linked shader program
 */
+ (Shader*)LoadShader : (NSString*)path {
	return[ResourceManager LoadShader : path withFragment : path nameAs : path];
}

/**
 * GetShader
 *
 * @param name to retrieve
 * @returns loaded, compiled and linked shader program
 *
 */
+ (Shader*)GetShader : (NSString*)name {
	return[ResourceManager.Shaders objectForKey : name];
}

/**
 * loadTextureFromFile
 *
 * @param file path to texture
 * @param alpha does the texture have an alpha channel?
 * @param name to cache as
 * @returns Texture
 *
 */
+ (Texture2D*)LoadTexture : (NSString*)path alpha : (BOOL)alpha nameAs : (NSString*)name {
	Texture2D *texture = [ResourceManager loadTextureFromFile : path alpha: alpha];
	[ResourceManager.Textures setObject : texture forKey : name];
	return texture;
}

/**
 * GetTexture
 *
 * @param name to retrieve
 * @returns Texture
 *
 */
+ (Texture2D*)GetTexture : (NSString*)name {
	return[ResourceManager.Textures objectForKey : name];
}

/**
 * loadShaderFromFile
 *
 * @param vertSource path to vertex shader
 * @param fragSource path to fragment shader
 * @returns loaded, compiled and linked shader program
 *
 */
+ (Shader*)loadShaderFromFile : (NSString*)vertSource withFragment : (NSString*)fragSource {

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

	Shader* shader = [[Shader alloc] init];
	[shader Compile : vertCode withFragment: fragCode];
	return shader;
}

/**
 * loadShaderFromFile
 *
 * @param vertSource path to vertex shader
 * @returns loaded, compiled and linked shader program
 *
 */
+ (Shader*)loadShaderFromFile : (NSString*)path {
	return [ResourceManager loadShaderFromFile : path withFragment : path];
}

/**
 * loadTextureFromFile
 *
 * @param path to texture
 * @param alpha does the texture have an alpha channel?
 * @returns Texture
 *
 */
+ (Texture2D*)loadTextureFromFile : (NSString*)path alpha : (BOOL)alpha {
	// Create Texture object
	int format = alpha ? GL_RGBA : GL_RGB;
	int width, height, channels;
	Texture2D* texture = [[Texture2D alloc] initWithPath: path format : format];
	// Load image
	unsigned char* image = stbi_load([path UTF8String], &width, &height, &channels, 0); 
	// generate texture
	[texture Generate: width :height :image];
	// And then free image data
	stbi_image_free(image);
	return texture;
}

/**
 * loadTextureFromFile
 *
 * @param path to texture
 * @returns Texture
 *
 */
+ (Texture2D*)loadTextureFromFile : (NSString*)path  {
	return[ResourceManager loadTextureFromFile : path alpha : YES];
}

@end