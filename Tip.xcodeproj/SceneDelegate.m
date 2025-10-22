#import "SceneDelegate.h"
#import "ViewController.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if (![scene isKindOfClass:[UIWindowScene class]]) { return; }
    UIWindowScene *windowScene = (UIWindowScene *)scene;

    self.window = [[[UIWindow alloc] initWithWindowScene:windowScene] autorelease];

    ViewController *homeViewController = [[[ViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:homeViewController] autorelease];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
