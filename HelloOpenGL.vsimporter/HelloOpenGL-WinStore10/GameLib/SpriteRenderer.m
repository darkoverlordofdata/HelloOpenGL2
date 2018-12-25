#import "SpriteRenderer.h"

typedef struct {
	float position[3];
	float color[4];
} Vertex;

static void glPerspective(GLfloat fov, GLfloat aspect, GLfloat znear, GLfloat zfar, GLuint attrib) {
	static Mat mat = { 0 };

	mat = glm_perspective(fov, aspect, znear, zfar);
	glUniformMatrix4fv(attrib, 1, 0, (const GLfloat*)&mat);
}

/**
 * SpriteRenderer class
 *
 */
@implementation SpriteRenderer;

/**
 * SpriteRenderer
 *
 * @param shader to use for rendering
 *
 */
- (id)initWithShader:(Shader*)shader  width : (int)w height : (int)h {

	if (self = [super init]) {
		_Shader = shader;
		_Width = w;
		_Height = h;
		[self InitRenderData];
	}
	return self;
}

- (void)InitRenderData {
	static VertexData vertices[] = {
		//	   X     Y     Z            U     V     
		{ {  1.0f, 1.0f, 0.0f },	{ 1.0f, 1.0f } }, // vertex 0
		{ { -1.0f, 1.0f, 0.0f },	{ 0.0f, 1.0f } }, // vertex 1
		{ {  1.0f,-1.0f, 0.0f },	{ 1.0f, 0.0f } }, // vertex 2
		{ { -1.0f,-1.0f, 0.0f },	{ 0.0f, 0.0f } }, // vertex 3
	};	// 4 vertices with 5 components (floats) each


	static uint8_t indexData[] = {
		0,1,2, // first triangle
		2,1,3, // second triangle
	};

	static Vertex Vertices[] = {
		{ {  1.0f,  1.0f, 0.0f },	{ 1.0f, 1.0f, 0.0f, 1.0f } },
		{ { -1.0f,  1.0f, 0.0f },	{ 1.0f, 0.0f, 0.0f, 1.0f } },
		{ {  1.0f, -1.0f, 0.0f },	{ 1.0f, 0.0f, 0.0f, 1.0f } },
		{ { -1.0f, -1.0f, 0.0f },	{ 1.0f, 0.0f, 1.0f, 1.0f } }
	};

	self.PositionAttrib = [self.Shader GetAttrib : @"_position"];
	self.ColorAttrib = [self.Shader GetAttrib : @"_color"];
	self.ProjectionAttrib = [self.Shader GetUniform : @"_projection"];
	self.TranslateAttrib = [self.Shader GetUniform : @"_translate"];

	glGenBuffers(1, &_VBO);
	glBindBuffer(GL_ARRAY_BUFFER, self.VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);

	glViewport(0, 0, self.Width, self.Height);
	float aspect = (GLfloat)self.Width / (GLfloat)self.Height;
	glPerspective(M_PI / 3, aspect, 0.01f, 100.0f, self.ProjectionAttrib);

	//=====================================================

	//glGenVertexArraysOES(1, &_VAO);
	//glGenBuffers(1, &_VBO);
	//glBindBuffer(GL_ARRAY_BUFFER, _VBO);
	//glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);

	//glBindVertexArrayOES(_VAO);
	//glEnableVertexAttribArray(0);
	//glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), (GLvoid*)0);
	//glBindBuffer(GL_ARRAY_BUFFER, 0);
	//glBindVertexArrayOES(0);
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
//- (void)Draw: (Texture2D*)texture : (Vec2)position : (Vec2)size : (GLfloat)rotate : (Vec3)color {
- (void)Draw {
	static uint8_t drawIndices[] = {
		0, 1, 2, 2, 1, 3
	};

	//Mat model = mat_identity();
	//model = glm_translate(model, (Vec3) { position.x, position.y, 0.0f });			// First translate (transformations are: scale happens first, then rotation and then finall translation happens; reversed order)
	//model = glm_translate(model, (Vec3) { 0.5f * size.x, 0.5f * size.y, 0.0f });	// Move origin of rotation to center of quad
	//model = glm_rotate(model, rotate, (Vec3) { 0.0f, 0.0f, 1.0f });					// Then rotate
	//model = glm_translate(model, (Vec3) { -0.5f * size.x, -0.5f * size.y, 0.0f });	// Move origin back
	//model = glm_scale(model, (Vec3) { size.x, size.y, 1.0f });						// Last scale

	[self.Shader Use];
	//[self.Shader Set:@"model" matrix:(GLfloat*)&model];
	//[self.Shader Set:@"spriteColor" vec3:&color];

	//glActiveTexture(GL_TEXTURE0);
	//[texture Bind];

	glEnableVertexAttribArray(self.PositionAttrib);
	glEnableVertexAttribArray(self.ColorAttrib);

	glVertexAttribPointer(self.PositionAttrib, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
	glVertexAttribPointer(self.ColorAttrib, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*)(sizeof(float) * 3));

	Mat translate = glm_translate(mat_identity(), (Vec3) { 0.0f, 0.0f, -1.0f });
	glUniformMatrix4fv(self.TranslateAttrib, 1, 0, (const GLfloat*)&translate);

	glDrawElements(GL_TRIANGLES, sizeof(drawIndices) / sizeof(uint8_t), GL_UNSIGNED_BYTE, drawIndices);



}

@end
