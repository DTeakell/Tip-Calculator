//
//  SettingsManager.h
//  Tip
//
//  Created by Dillon Teakell on 11/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Theme Color Enum
typedef NS_ENUM(NSInteger, ThemeColorType) {
    ThemeColorTypeRed,
    ThemeColorTypeDefault,
    ThemeColorTypeYellow,
    ThemeColorTypeGreen,
    ThemeColorTypeMint,
    ThemeColorTypeTeal,
    ThemeColorTypeCyan,
    ThemeColorTypeBlue,
    ThemeColorTypeIndigo,
    ThemeColorTypePurple,
    ThemeColorTypePink,
    ThemeColorTypeGray
};

// App Icon Enum
typedef NS_ENUM(NSInteger, AppIconType) {
    AppIconTypeRed,
    AppIconTypeDefault
};


@interface SettingsManager : NSObject

@property (nonatomic, assign) ThemeColorType currentTheme;
@property (nonatomic, assign) BOOL isRoundedTotalSwitchActive;
@property (nonatomic, assign) BOOL isSaveLastTipPercentageSwitchActive;
@property (nonatomic, assign) double tipPercentageIndex;
@property (nonatomic, assign) double customTipPercentage;

// A singleton so this manager is accessible everywhere
+ (instancetype) sharedManager;

// Theme Utilities
- (UIColor *) colorForTheme: (ThemeColorType) theme;
- (NSString *) nameForTheme: (ThemeColorType) theme;
- (ThemeColorType) themeFromString: (NSString *) themeName;
- (NSArray <NSString *> *) allThemeNames;
- (void) setCurrentTheme: (ThemeColorType) currentTheme;

// App Icon Utilities
- (NSString *) nameForAppIcon: (AppIconType) appIcon;
- (NSString *) displayNameForAppIcon: (AppIconType) appIcon;
- (void) setAlternateAppIcon: (AppIconType) appIcon;



// Load & Save Methods
- (void) saveCurrentSettings;
- (void) loadCurrentSettings;



@end
