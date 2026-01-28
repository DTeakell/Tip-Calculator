//
//  AppDelegate.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SettingsManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - Application Configuration

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // First time launch settings
    if (![[NSUserDefaults standardUserDefaults] boolForKey: @"HasLaunchedOnce"]) {
        [SettingsManager sharedManager].currentTheme = ThemeColorTypeDefault;
        [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"HasLaunchedOnce"];
    }
    return YES;
}

#pragma mark - UISceneSession Configuration

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    
    // Create a name for the configuration
    NSString *configurationName = @"Default Configuration";
    
    // Make a new configuration
    UISceneConfiguration *configuration = [[[UISceneConfiguration alloc] initWithName: configurationName sessionRole: connectingSceneSession.role] autorelease];
    
    [configurationName release];
    
    return configuration;
}

- (void) dealloc {
    [super dealloc];
}

@end
