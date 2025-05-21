//
//  AppDelegate.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Make window
<<<<<<< HEAD
    UIWindow *window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window = window;
    [window release];
    
    // Create view controller
    ViewController *homeViewController = [[[ViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController: homeViewController] autorelease];
=======
    self.window = [[[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]] autorelease];
    
    // Create view controller
    ViewController *homeViewController = [[[ViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: homeViewController];
>>>>>>> test
    
    // Assign to root view controller
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

<<<<<<< HEAD
- (void) dealloc {
    [_window release];
    [super dealloc];
}

=======
>>>>>>> test
@end
