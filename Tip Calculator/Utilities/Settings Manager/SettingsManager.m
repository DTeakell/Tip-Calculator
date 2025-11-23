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
        case ThemeColorTypeDefault: return [UIColor systemOrangeColor];
        case ThemeColorTypeYellow: return [UIColor systemYellowColor];
        case ThemeColorTypeGreen: return [UIColor systemGreenColor];
        case ThemeColorTypeMint: return [UIColor systemMintColor];
        case ThemeColorTypeTeal: return [UIColor systemTealColor];
        case ThemeColorTypeCyan: return [UIColor systemCyanColor];
        case ThemeColorTypeBlue: return [UIColor systemBlueColor];
        case ThemeColorTypeIndigo: return [UIColor systemIndigoColor];
        case ThemeColorTypePurple: return [UIColor systemPurpleColor];
        case ThemeColorTypePink: return [UIColor systemPinkColor];
        case ThemeColorTypeGray: return [UIColor systemGrayColor];
    }
}

/// Gets the string value of the theme
- (NSString *) nameForTheme:(ThemeColorType)theme {
    switch (theme) {
        case ThemeColorTypeRed: return NSLocalizedString(@"Red", @"");
        case ThemeColorTypeDefault: return NSLocalizedString(@"Orange", @"");
        case ThemeColorTypeYellow: return NSLocalizedString(@"Yellow", @"");
        case ThemeColorTypeGreen: return NSLocalizedString(@"Green", @"");
        case ThemeColorTypeMint: return NSLocalizedString(@"Mint", @"");
        case ThemeColorTypeTeal: return NSLocalizedString(@"Teal", @"");
        case ThemeColorTypeCyan: return NSLocalizedString(@"Cyan", @"");
        case ThemeColorTypeBlue: return NSLocalizedString(@"Blue", @"");
        case ThemeColorTypeIndigo: return NSLocalizedString(@"Indigo", @"");
        case ThemeColorTypePurple: return NSLocalizedString(@"Purple", @"");
        case ThemeColorTypePink: return NSLocalizedString(@"Pink", @"");
        case ThemeColorTypeGray: return NSLocalizedString(@"Gray", @"");
    }
}

/// Gets the theme from the string value
- (ThemeColorType) themeFromString:(NSString *)themeName {
    if ([themeName isEqualToString: NSLocalizedString(@"Red", @"Theme Name Red")]) {
        return ThemeColorTypeRed;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Orange", @"Theme Name Blue")]) {
        return ThemeColorTypeDefault;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Yellow", @"Theme Name Cyan")]) {
        return ThemeColorTypeYellow;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Green", @"Theme Name Pink")])  {
        return ThemeColorTypeGreen;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Mint", @"Theme Name Purple")]) {
        return ThemeColorTypeMint;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Teal", @"Theme Name Purple")]) {
        return ThemeColorTypeTeal;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Cyan", @"Theme Name Purple")]) {
        return ThemeColorTypeCyan;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Blue", @"Theme Name Purple")]) {
        return ThemeColorTypeBlue;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Indigo", @"Theme Name Purple")]) {
        return ThemeColorTypeIndigo;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Purple", @"Theme Name Purple")]) {
        return ThemeColorTypePurple;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Pink", @"Theme Name Purple")]) {
        return ThemeColorTypePink;
    } else if ([themeName isEqualToString: NSLocalizedString(@"Gray", @"Theme Name Purple")]) {
        return ThemeColorTypeGray;
    } else {
        return ThemeColorTypeDefault;
    }
}


/// Gets an array of all theme color names
- (NSArray <NSString *> *) allThemeNames {
    NSMutableArray *colorNames = [NSMutableArray array];
    
    for (NSInteger i = ThemeColorTypeRed; i <= ThemeColorTypeGray; i++) {
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

