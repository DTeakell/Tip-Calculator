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
    self.window = [[[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]] autorelease];
    
    // Create view controller
    ViewController *homeViewController = [[[ViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: homeViewController];
    
    // Assign to root view controller
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
