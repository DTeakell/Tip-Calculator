//
//  SettingsManager.m
//  Tip
//
//  Created by Dillon Teakell on 11/10/25.
//

#import <Foundation/Foundation.h>
#import "SettingsManager.h"

static NSString *const selectedThemeKey = @"selectedTheme";

@implementation SettingsManager


#pragma mark - Singleton

+ (instancetype) sharedManager {
    static SettingsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance loadCurrentTheme];
    });
    
    return sharedInstance;
}

#pragma mark - Theme Color Methods

- (UIColor *) colorForTheme:(ThemeColorType)theme {
    switch (theme) {
        case ThemeColorTypeRed: return [UIColor systemRedColor];
        case ThemeColorTypeBlue: return [UIColor systemBlueColor];
        case ThemeColorTypeCyan: return [UIColor systemCyanColor];
        case ThemeColorTypePink: return [UIColor systemPinkColor];
        case ThemeColorTypeOrange: return [UIColor systemOrangeColor];
        case ThemeColorTypePurple: return [UIColor systemPurpleColor];
    }
}

- (NSString *) nameForTheme:(ThemeColorType)theme {
    switch (theme) {
        case ThemeColorTypeRed: return NSLocalizedString(@"Red", @"Theme Name Red");
        case ThemeColorTypeBlue: return NSLocalizedString(@"Blue", @"Theme Name Blue");
        case ThemeColorTypeCyan: return NSLocalizedString(@"Cyan", @"Theme Name Cyan");
        case ThemeColorTypePink: return NSLocalizedString(@"Pink", @"Theme Name Pink");
        case ThemeColorTypeOrange: return NSLocalizedString(@"Orange", @"Theme Name Orange");
        case ThemeColorTypePurple: return NSLocalizedString(@"Purple", @"Theme Name Purple");
    }
}

- (NSArray <NSString *> *) allThemeNames {
    NSMutableArray *colorNames = [NSMutableArray array];
    
    for (NSInteger i = ThemeColorTypeRed; i <= ThemeColorTypePurple; i++) {
        [colorNames addObject: [self nameForTheme: i]];
    }
    return [colorNames copy];
}

#pragma mark - Applying Theme
- (void)applyThemeToWindow:(UIWindow *)window {
    window.tintColor = [self colorForTheme: self.currentTheme];
}


#pragma mark - Load & Save Methods

/// Saves the current theme to disk
- (void) saveCurrentTheme {
    // Get the User Defaults Store
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Set the current theme
    [userDefaults setInteger: self.currentTheme forKey: selectedThemeKey];
}

/// Loads the current theme from disk
- (void) loadCurrentTheme {
    // Create the User Defaults store
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger storedValue = [userDefaults integerForKey: selectedThemeKey];
    self.currentTheme = (ThemeColorType)storedValue;
}



@end
