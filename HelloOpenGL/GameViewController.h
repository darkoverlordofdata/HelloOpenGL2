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

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "tglm/tglm.h"
#import "ResourceManager.h"
#import "SpriteRenderer.h"
#import "Shader.h"

@interface OpenGLView : UIView
+ (Class)layerClass;
@end

@interface GameViewController : UIViewController

@property (nonatomic) EAGLContext* Ctx;
@property (nonatomic) OpenGLView* OutputView;
@property (nonatomic) CADisplayLink* DisplayLink;
@property (nonatomic) Shader* Shader;
@property (nonatomic) SpriteRenderer* Renderer;
@property (nonatomic) Texture2D* Texture;
@property GLint Width;
@property GLint Height;
@property CGSize CurSize;
@property GLuint Framebuffer;
@property GLuint Renderbuffer;
@property GLuint Depthbuffer;
@property GLuint PositionAttrib;
@property GLuint ColorAttrib;
@property GLuint ProjectionAttrib;
//@property GLuint RotateAttrib;
@property GLuint TranslateAttrib;
@property GLfloat Aspect;
@property GLuint VBO;
@property GLuint ColorBuffer;

@end
