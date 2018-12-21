//******************************************************************************
//
// Copyright (c) 2015 Microsoft Corporation. All rights reserved.
//
// This code is licensed under the MIT License (MIT).
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//******************************************************************************

//UIKeyInputEscape
//https://nshipster.com/uikeycommand/
//addKeyCommand:' is deprecated: method not yet implemented [-Wdeprecated-declarations]

#import "GameViewController.h"


typedef struct {
    float pps[3];
    float color[4];
} Vertex;

static Vertex cubeVertices[] = { 
	{ { -1.0f, -1.0f, -1.0f },	{ 0.0f, 1.0f, 0.0f, 1.0f } },
    { { 1.0f, -1.0f, -1.0f },	{ 0.0f, 1.0f, 0.0f, 1.0f } },
    { { 1.0f, 1.0f, -1.0f },	{ 1.0f, 0.5f, 0.0f, 1.0f } },
    { { -1.0f, 1.0f, -1.0f },	{ 1.0f, 0.5f, 0.0f, 1.0f } },
    { { -1.0f, -1.0f, 1.0f },	{ 1.0f, 0.0f, 0.0f, 1.0f } },
    { { 1.0f, -1.0f, 1.0f },	{ 1.0f, 0.0f, 0.0f, 1.0f } },
    { { 1.0f, 1.0f, 1.0f },		{ 0.0f, 0.0f, 1.0f, 1.0f } },
    { { -1.0f, 1.0f, 1.0f },	{ 1.0f, 0.0f, 1.0f, 1.0f } } 
};

@implementation OpenGLView
+ (Class)layerClass {
	return[CAEAGLLayer class];
}
@end

static void glPerspective(GLfloat fov, GLfloat aspect, GLfloat znear, GLfloat zfar, GLuint attrib) {
	static Mat mat = { 0 };

	mat = glm_perspective(fov, aspect, znear, zfar);
	glUniformMatrix4fv(attrib, 1, 0, (const GLfloat*)&mat);
}

@implementation GameViewController;

- (void)viewWillLayoutSubviews {
    [EAGLContext setCurrentContext:self.Ctx];
    if (!CGSizeEqualToSize(self.CurSize, self.OutputView.bounds.size)) {
        self.CurSize = self.OutputView.bounds.size;

        if (self.Renderbuffer != 0) {
            glDeleteRenderbuffers(1, &_Renderbuffer);
            self.Renderbuffer = 0;
        }

        if (self.Depthbuffer != 0) {
            glDeleteRenderbuffers(1, &_Depthbuffer);
            self.Depthbuffer = 0;
        }

        if (self.Framebuffer != 0) {
            glDeleteFramebuffers(1, &_Framebuffer);
            self.Depthbuffer = 0;
        }

        glGenFramebuffers(1, &_Framebuffer);
        glGenRenderbuffers(1, &_Renderbuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, self.Framebuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, self.Renderbuffer);

#ifdef WINOBJC
        self.OutputView.layer.contentsScale =
            [[UIApplication displayMode] currentMagnification] * [[UIApplication displayMode] hostScreenScale];
#endif

        [self.Ctx renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)self.OutputView.layer];
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, self.Renderbuffer);

        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_Width);
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_Height);

        glGenRenderbuffers(1, &_Depthbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, self.Depthbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.Width, self.Height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, self.Depthbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, self.Renderbuffer);
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClearDepthf(1.0f);
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LEQUAL);

        glGenBuffers(1, &_PositionBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, self.PositionBuffer);
        glBufferData(GL_ARRAY_BUFFER, sizeof(cubeVertices), cubeVertices, GL_STATIC_DRAW);

        glViewport(0, 0, self.Width, self.Height);
        self.Aspect = (GLfloat)self.Width / (GLfloat)self.Height;
        glPerspective(M_PI / 3, self.Aspect, 0.01f, 100.0f, self.ProjectionAttrib);
    }
}

- (void)viewDidLoad {

	//NSString *path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png"];
	//int width, height, nrChannels;
	//unsigned char *data = stbi_load([path UTF8String], &width, &height, &nrChannels, 0);
	//free(data);

	/**
	 * Get the gl context
	 */
    self.Ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.Ctx];

	/**
	 * Load the shader
	 */
	self.Shader = [[Shader alloc]init];
	[self.Shader Compile : @"demo"];

	self.PositionAttrib		= [self.Shader GetAttrib : @"_position"];
	self.ColorAttrib		= [self.Shader GetAttrib : @"_color"];
	self.ProjectionAttrib	= [self.Shader GetUniform : @"_projection"];
	self.RotateAttrib		= [self.Shader GetUniform : @"_rotate"];
	self.TranslateAttrib	= [self.Shader GetUniform : @"_translate"];

    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.OutputView = [[OpenGLView alloc] initWithFrame:frame];
    self.OutputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.DisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render)];
	self.view.backgroundColor = [UIColor blackColor];
	[self.view addSubview:self.OutputView];

}

- (void)viewWillAppear:(BOOL)animated {
    [self.DisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.DisplayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)render {
    [EAGLContext setCurrentContext:self.Ctx];

	glClearColor(0.372549, 0.623529, 0.623529, 1);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	[self.Shader Use];
    glEnableVertexAttribArray(self.PositionAttrib);
    glEnableVertexAttribArray(self.ColorAttrib);

    glVertexAttribPointer(self.PositionAttrib, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(self.ColorAttrib, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*)(sizeof(float) * 3));

    CATransform3D rotate = CATransform3DMakeRotation(self.CubeAngle, 1.0f, 0.0f, 0.0f);
    rotate = CATransform3DRotate(rotate, self.CubeAngle, 0.0f, 1.0f, 0.0f);
	glUniformMatrix4fv(self.RotateAttrib, 1, 0, (const GLfloat*)&rotate);

    CATransform3D translate = CATransform3DMakeTranslation(0.0f, 0.0f, -5.0f);
	glUniformMatrix4fv(self.TranslateAttrib, 1, 0, (const GLfloat*)&translate);


    self.CubeAngle += 1.0f / 180.0f * M_PI;

    static uint8_t drawIndices[] = { 
		0, 4, 5, 0, 5, 1, 
		1, 5, 6, 1, 6, 2, 
		2, 6, 7, 2, 7, 3,
        3, 7, 4, 3, 4, 0, 
		4, 7, 6, 4, 6, 5, 
		3, 0, 1, 3, 1, 2 
	};

    glDrawElements(GL_TRIANGLES, sizeof(drawIndices) / sizeof(uint8_t), GL_UNSIGNED_BYTE, drawIndices);

    [self.Ctx presentRenderbuffer:GL_RENDERBUFFER];
}

/**
 * mouse events
 */
-(void)touchesBegan:(NSSet *)touches withEvent : (UIEvent *)event
{
	NSLog(@"Touches Began");
}


@end
