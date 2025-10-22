//
//  SceneDelegate.m
//  Tip
//
//  Created by Dillon Teakell on 10/22/25.
//

#import "SceneDelegate.h"
#import <UIKit/UIKit.h>
#import "ViewController.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    // Make a new window scene
    if (![scene isKindOfClass: [UIWindowScene class]]) {
        return;
    }
    UIWindowScene *windowScene = (UIWindowScene *) scene;
    
    self.window = [[[UIWindow alloc] initWithWindowScene: windowScene] autorelease];
    
    // Create View Controller
    ViewController *homeViewController = [[[ViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController: homeViewController] autorelease];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (void) dealloc {
    [self.window release];
    [super dealloc];
}

@end
