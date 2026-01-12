//
//  SettingsManager.m
//  Tip
//
//  Created by Dillon Teakell on 11/10/25.
//

#import <Foundation/Foundation.h>
#import "SettingsManager.h"
#import "TipCalculator.h"

#pragma mark - UserDefaults Keys
static NSString *const selectedThemeKey = @"selectedTheme";
static NSString *const roundedTotalKey = @"roundedTotalKey";
static NSString *const customTipPercentageKey = @"customTipPercentageKey";
static NSString *const saveTipPercentageKey = @"saveTipPercentageKey";
static NSString *const tipPercentageIndexKey = @"tipPercentageKey";


@implementation SettingsManager

#pragma mark - Singleton

/// Creates one instance of `SettingsManager` to be used throughout the app
+ (instancetype) sharedManager {
    static SettingsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance loadCurrentSettings];
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
    } else if ([themeName isEqualToString: NSLocalizedString(@"Orange", @"Theme Name Default")]) {
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


/// Sets the current theme and sends a notification to `NSNotificationCenter` to change the theme.
- (void) setCurrentTheme:(ThemeColorType)currentTheme {
    _currentTheme = currentTheme;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"ThemeDidChangeNotification" object: self];
}

#pragma mark - App Icon Methods

/// Returns the name of the app icon to be used with `setAlternateIcon`
- (NSString *) nameForAppIcon: (AppIconType) appIcon {
    switch (appIcon) {
        case AppIconTypeRed: return @"AppIcon-Red";
        case AppIconTypeDefault: return @"AppIcon";
    }
}

/// Returns the display name for the app icon
- (NSString *) displayNameForAppIcon: (AppIconType) appIcon {
    switch (appIcon) {
        case AppIconTypeRed: return NSLocalizedString(@"Red", @"App Icon Color Red");
        case AppIconTypeDefault: return NSLocalizedString(@"Orange", @"App Icon Color Orange");
    }
}

/// Sets the alternate app icon and sends an alert to the user based on the result
- (void) setAlternateAppIcon: (AppIconType) appIcon {
    // Get the icon name
    NSString *appIconName = [self nameForAppIcon: appIcon];
    
    // Set the alternate icon name to the new icon name
    [UIApplication.sharedApplication setAlternateIconName: appIconName
                                        completionHandler:^(NSError * _Nullable error) {
        
        // Error Handling with Completion Handler
        if (error) {
            NSLog(@"App Icon Change Unsuccessful: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Icon Change Failed", @"Error Message Title") message: error.localizedDescription preferredStyle: UIAlertControllerStyleAlert];
            });
        } else {
            NSLog(@"App Icon Changed Successfully!");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Icon Changed", @"Alert Message Title") message: NSLocalizedString(@"Icon has been changed successfully.", @"Alert Message") preferredStyle: UIAlertControllerStyleAlert];
            });
        }
    }];
}


#pragma mark - Load & Save Methods

/// Saves the current settings
- (void) saveCurrentSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger: self.currentTheme forKey: selectedThemeKey];
    [userDefaults setDouble: self.customTipPercentage forKey: customTipPercentageKey];
    [userDefaults setBool: self.isRoundedTotalSwitchActive forKey: roundedTotalKey];
    [userDefaults setBool: self.isSaveLastTipPercentageSwitchActive forKey: saveTipPercentageKey];
    [userDefaults setInteger: self.tipPercentageIndex forKey: tipPercentageIndexKey];
}

/// Loads the current settings from disk
- (void) loadCurrentSettings {
    // Create the User Defaults store
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger storedThemeValue = [userDefaults integerForKey:selectedThemeKey];
    BOOL storedRoundedTotalValue = [userDefaults boolForKey: roundedTotalKey];
    BOOL saveTipPercentageValue = [userDefaults boolForKey: saveTipPercentageKey];
    NSInteger saveTipPercentageIndexValue = [userDefaults integerForKey: tipPercentageIndexKey];
    double customTipPercentageValue = [userDefaults doubleForKey: customTipPercentageKey];
    
    ThemeColorType loadedTheme = (ThemeColorType)storedThemeValue;
    
    // Validate range (assuming enum is contiguous from Red to Purple)
    if (loadedTheme < ThemeColorTypeRed || loadedTheme > ThemeColorTypeGray) {
        loadedTheme = ThemeColorTypeDefault;
    }
    
    // First assign flags from stored values
    _isSaveLastTipPercentageSwitchActive = saveTipPercentageValue;
    _customTipPercentage = customTipPercentageValue;
    _isRoundedTotalSwitchActive = storedRoundedTotalValue;
    _currentTheme = loadedTheme;

    // Then load the last tip percentage if the switch is on; clamp to non-negative
    NSInteger restoredIndex = saveTipPercentageIndexValue;
    if (restoredIndex < 0) {
        restoredIndex = 0;
    }
    
    if (_isSaveLastTipPercentageSwitchActive) {
        _tipPercentageIndex = restoredIndex;
    } else {
        _tipPercentageIndex = 0;
    }
}



@end

