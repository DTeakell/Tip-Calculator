//
//  SettingsViewController.h
//  Tip
//
//  Created by Dillon Teakell on 10/25/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController

// UI Properties
// Accent Color UI
@property (nonatomic, retain) UILabel *themeColorLabel;
@property (nonatomic, retain) UIPickerView *themeColorPicker;

// Navigation Bar
@property (nonatomic, strong) UINavigationBar *navigationBar;

// App Icon UI
@property (nonatomic, retain) UILabel *appIconMenuLabel;
@property (nonatomic, retain) NSString *appIcon;

// Show Rounded Values UI
@property (nonatomic, retain) UILabel *showRoundedValuesLabel;
@property (nonatomic, retain) UISwitch *showRoundedValuesSwitch;

// Table View
@property (nonatomic, retain) UITableView *settingsTableView;

// Data Properties
@property (nonatomic, assign) NSArray <UIColor *> *themeColors;
@property (nonatomic, assign) BOOL *isRoundedValuesSwitchOn;

@end
