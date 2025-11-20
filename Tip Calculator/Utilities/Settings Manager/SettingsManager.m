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

/// Creates one instance of `SettingsManager` to be used throughout the app
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

/// Gets the `UIColor` value from the theme color
- (UIColor *) colorForTheme:(ThemeColorType)theme {
    switch (theme) {
        case ThemeColorTypeRed: return [UIColor systemRedColor];
        case ThemeColorTypeBlue: return [UIColor systemBlueColor];
        case ThemeColorTypeCyan: return [UIColor systemCyanColor];
        case ThemeColorTypePink: return [UIColor systemPinkColor];
        case ThemeColorTypeOrange: return [UIColor systemOrangeColor];
        case ThemeColorTypePurple: return [UIColor systemPurpleColor];
        default: return [UIColor systemBlueColor];
    }
}

/// Gets the string value of the theme
- (NSString *) nameForTheme:(ThemeColorType)theme {
    switch (theme) {
        case ThemeColorTypeRed: return NSLocalizedString(@"Red", @"Theme Name Red");
        case ThemeColorTypeBlue: return NSLocalizedString(@"Blue", @"Theme Name Blue");
        case ThemeColorTypeCyan: return NSLocalizedString(@"Cyan", @"Theme Name Cyan");
        case ThemeColorTypePink: return NSLocalizedString(@"Pink", @"Theme Name Pink");
        case ThemeColorTypePurple: return NSLocalizedString(@"Purple", @"Theme Name Purple");
        default: return NSLocalizedString(@"Orange", @"Theme Name Default");
    }
}

/// Gets the theme from the string value
- (ThemeColorType) themeFromString:(NSString *)themeName {
    if ([themeName isEqualToString: NSLocalizedString(@"Red", @"Theme Name Red")]) {
        return ThemeColorTypeRed;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Blue", @"Theme Name Blue")]) {
        return ThemeColorTypeBlue;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Cyan", @"Theme Name Cyan")]) {
        return ThemeColorTypeCyan;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Pink", @"Theme Name Pink")])  {
        return ThemeColorTypePink;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Purple", @"Theme Name Purple")]) {
        return ThemeColorTypePurple;
    }
    // Default fallback
    return ThemeColorTypeOrange;
}


/// Gets an array of all theme color names
- (NSArray <NSString *> *) allThemeNames {
    NSMutableArray *colorNames = [NSMutableArray array];
    
    for (NSInteger i = ThemeColorTypeRed; i <= ThemeColorTypePurple; i++) {
        [colorNames addObject: [self nameForTheme: i]];
    }
    return [colorNames copy];
}

#pragma mark - Setting Theme

- (void) setCurrentTheme:(ThemeColorType)currentTheme {
    _currentTheme = currentTheme;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"ThemeDidChangeNotification" object: self];
}


#pragma mark - Load & Save Methods

/// Saves the current theme to disk
- (void) saveCurrentTheme {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger: self.currentTheme forKey: selectedThemeKey];
}

/// Loads the current theme from disk
- (void) loadCurrentTheme {
    // Create the User Defaults store
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger storedValue = [userDefaults integerForKey:selectedThemeKey];
    ThemeColorType loaded = (ThemeColorType)storedValue;
    // Validate range (assuming enum is contiguous from Red to Purple)
    if (loaded < ThemeColorTypeRed || loaded > ThemeColorTypePurple) {
        loaded = ThemeColorTypeBlue;
    }
    _currentTheme = loaded;
}



@end

