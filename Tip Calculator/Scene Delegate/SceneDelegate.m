//
//  SceneDelegate.m
//  Tip
//
//  Created by Dillon Teakell on 10/22/25.
//

#import "SceneDelegate.h"
#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "SettingsManager.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    // Make a new window scene
    if (![scene isKindOfClass: [UIWindowScene class]]) {
        return;
    }
    
    // Initialize a new window scene
    UIWindowScene *windowScene = (UIWindowScene *) scene;
    self.window = [[[UIWindow alloc] initWithWindowScene: windowScene] autorelease];
    
    
    // Create View Controller
    HomeViewController *homeViewController = [[[HomeViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController: homeViewController] autorelease];
    
    
    // Assign root to the navigation controller
    self.window.rootViewController = navigationController;
    
    // Test theme manager
    [[SettingsManager sharedManager] applyThemeToWindow: self.window];
    
    [self.window makeKeyAndVisible];
}


- (void) dealloc {
    [_window release];
    [super dealloc];
}

@end
