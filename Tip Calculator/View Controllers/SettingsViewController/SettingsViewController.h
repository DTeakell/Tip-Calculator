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
@property (nonatomic, retain) UIMenu *accentColorMenu;
@property (nonatomic, strong) UINavigationBar *navigationBar;

//TODO: Property for choosing app icon
@property (nonatomic, retain) NSString *appIcon;

@property (nonatomic, retain) UISwitch *showRoundedValuesSwitch;

@property (nonatomic, assign) NSArray <UIColor *> *accentColors;
@property (nonatomic, assign) BOOL *isRoundedValuesSwitchOn;

@end
