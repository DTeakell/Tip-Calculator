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
    ThemeColorTypeBlue,
    ThemeColorTypeOrange,
    ThemeColorTypePink,
    ThemeColorTypeCyan,
    ThemeColorTypePurple
};


@interface SettingsManager : NSObject

@property (nonatomic, assign) ThemeColorType currentTheme;

// A singleton so this manager is accessible everywhere
+ (instancetype) sharedManager;

// Theme Utilities
- (UIColor *) colorForTheme: (ThemeColorType) theme;
- (NSString *) nameForTheme: (ThemeColorType) theme;
- (NSArray <NSString *> *) allThemeNames;

// Load & Save Methods
- (void) saveCurrentTheme;
- (void) loadCurrentTheme;

// Apply to Window
- (void) applyThemeToWindow: (UIWindow *) window;

@end
