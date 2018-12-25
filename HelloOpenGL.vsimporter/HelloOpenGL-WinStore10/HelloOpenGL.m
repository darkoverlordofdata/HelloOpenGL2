#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import "Log.h"

@interface HelloOpenGLApp : NSObject
@property (nonatomic) UIWindow* mainWindow;
@end

@implementation HelloOpenGLApp

- (void)applicationDidFinishLaunching:(UIApplication*)app {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    _mainWindow = [[UIWindow alloc] initWithFrame:bounds];

    GameViewController* c = [[GameViewController alloc] init];
    _mainWindow.rootViewController = c;
    _mainWindow.backgroundColor = [UIColor whiteColor];

    [_mainWindow makeKeyAndVisible];
}

@end

#ifdef WINOBJC
// Tell the WinObjC runtime how large to render the application
@implementation UIApplication (UIApplicationInitialStartupMode)
+ (void)setStartupDisplayMode:(WOCDisplayMode*)mode {
    mode.autoMagnification = TRUE;
    mode.sizeUIWindowToFit = TRUE;
    mode.fixedWidth = 0;
    mode.fixedHeight = 0;
    mode.magnification = 1.0;
}
@end
#endif
