#import "SpriteRenderer.h"

@implementation SpriteRenderer;

/**
 * SpriteRenderer
 *
 * @param shader to use for rendering
 *
 */
-(id)initWithShader:(Shader*)shader {

	if (self = [super init]) {
		_Shader = shader;
		[self InitRenderData];
	}
	return self;
}

-(void)InitRenderData {
	static GLfloat vertices[] = {
		// Pos      // Tex
		0.0f, 1.0f, 0.0f, 1.0f,
		1.0f, 0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 0.0f,

		0.0f, 1.0f, 0.0f, 1.0f,
		1.0f, 1.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 1.0f, 0.0f
	};

	glGenVertexArraysOES(1, &_VAO);
	glGenBuffers(1, &_VBO);

	glBindBuffer(GL_ARRAY_BUFFER, _VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glBindVertexArrayOES(_VAO);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), (GLvoid*)0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindVertexArrayOES(0);
}

/**
 * Draw
 *
 * @param texture the image to render
 * @param position to render at
 * @param size to render
 * @param rotate amount to rotate by
 * @param color to tint
 *
 */
-(void)Draw: (Texture2D*)texture : (Vec2)position : (Vec2)size : (GLfloat)rotate : (Vec3)color {

	Mat model = mat_identity();
	model = glm_translate(model, (Vec3) { position.x, position.y, 0.0f });			// First translate (transformations are: scale happens first, then rotation and then finall translation happens; reversed order)
	model = glm_translate(model, (Vec3) { 0.5f * size.x, 0.5f * size.y, 0.0f });	// Move origin of rotation to center of quad
	model = glm_rotate(model, rotate, (Vec3) { 0.0f, 0.0f, 1.0f });					// Then rotate
	model = glm_translate(model, (Vec3) { -0.5f * size.x, -0.5f * size.y, 0.0f });	// Move origin back
	model = glm_scale(model, (Vec3) { size.x, size.y, 1.0f });						// Last scale

	[self.Shader Use];
	[self.Shader Set:@"model" matrix:(GLfloat*)&model];
	[self.Shader Set:@"spriteColor" vec3:&color];

	glActiveTexture(GL_TEXTURE0);
	[texture Bind];

	glBindVertexArrayOES(self.VAO);
	glDrawArrays(GL_TRIANGLES, 0, 6);
	glBindVertexArrayOES(0);
}

@end
