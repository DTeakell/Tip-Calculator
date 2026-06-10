//
//  SettingsViewController.m
//  Tip
//
//  Created by Dillon Teakell on 10/25/25.
//

#import "SettingsViewController.h"
#import "ThemeColorCell.h"
#import "ThemeSelectionViewController.h"
#import "ShowRoundedTotalsCell.h"
#import "SaveTipPercentageCell.h"
#import "SettingsManager.h"

#import <UIKit/UIKit.h>

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingsViewController

#pragma mark - Life cycle Methods

- (void) loadView {
    UIView *modalView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = modalView;
    [modalView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applyTheme:) name: @"ThemeDidChangeNotification" object: nil];
    
    [self setupSettingsViewController];
    [self setupNavigationBarButtons];
    [self setupTableViewUI];
}



#pragma mark - UI Setup Methods

/// Sets up the background color and title of the Settings View Controller
- (void) setupSettingsViewController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = NSLocalizedString(@"Settings", "Settings Title");
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

/// Sets up the buttons in the navigation controller
- (void) setupNavigationBarButtons {
    
    UIColor *color = [[SettingsManager sharedManager] colorForTheme: [SettingsManager sharedManager].currentTheme];
    UIBarButtonItem *exitButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemClose target: self action: @selector(exitButtonPressed)];
    self.navigationItem.leftBarButtonItem = exitButton;
    [exitButton release];
    
    if (@available (iOS 26.0, *)) {}
    else {
        self.navigationItem.leftBarButtonItem.tintColor = color;
    }
}


/// Sets up the table view and sets constraints
- (void) setupTableViewUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectZero style: UITableViewStyleInsetGrouped];
    self.settingsTableView = tableView;
    [tableView release];
    
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    
    self.settingsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.settingsTableView];
    
    [self.settingsTableView registerClass: [ThemeColorCell class] forCellReuseIdentifier: @"ThemeColorCell"];
    [self.settingsTableView registerClass: [ShowRoundedTotalsCell class] forCellReuseIdentifier: @"ShowRoundedTotalsCell"];
    [self.settingsTableView registerClass: [SaveTipPercentageCell class] forCellReuseIdentifier: @"SaveTipPercentageCell"];
    
    [NSLayoutConstraint activateConstraints:@[
        [tableView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

/// Applies the current theme to the view controller
- (void) applyTheme: (NSNotification *) notification {
    ThemeColorType theme = [[SettingsManager sharedManager] currentTheme];
    UIColor *color = [[SettingsManager sharedManager] colorForTheme: theme];
    self.navigationItem.rightBarButtonItem.tintColor = color;
    self.selectedThemeLabel.text = [[SettingsManager sharedManager] nameForTheme: theme];
    self.showRoundedValuesSwitch.onTintColor = color;
    self.saveTipPercentageSwitch.onTintColor = color;
    
    if (@available(iOS 26.0, *)) {}
    else {
        self.navigationItem.leftBarButtonItem.tintColor = color;
        self.navigationController.navigationBar.tintColor = color;
    }
}



# pragma mark - Table View Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.estimatedRowHeight = 85;
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    // Theme Color Cell
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeColorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ThemeColorCell"];
        self.themeColorLabel = cell.themeColorLabel;
        self.selectedThemeLabel = cell.selectedColorLabel;
        return cell;
    }
    
    // Show Rounded Totals Cell
    if (indexPath.section == 1 && indexPath.row == 0) {
        ShowRoundedTotalsCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ShowRoundedTotalsCell"];
        self.showRoundedValuesLabel = cell.showRoundedTotalsLabel;
        self.showRoundedValuesSwitch = cell.showRoundedTotalsSwitch;
        self.showRoundedValuesSwitch.on = [SettingsManager sharedManager].isRoundedTotalSwitchActive;
        [self.showRoundedValuesSwitch addTarget: self action: @selector(roundedTotalSwitchTapped) forControlEvents:UIControlEventValueChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    // Save Tip Percentage Selection Cell
    if (indexPath.section == 1 && indexPath.row == 1) {
        SaveTipPercentageCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SaveTipPercentageCell"];
        self.saveTipPercentageLabel = cell.savePercentageLabel;
        self.saveTipPercentageSwitch = cell.saveTipPercentageSwitch;
        self.saveTipPercentageSwitch.on = [SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive;
        [self.saveTipPercentageSwitch addTarget: self action: @selector(saveTipPercentageSwitchTapped) forControlEvents: UIControlEventValueChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    // Theme Selection
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeSelectionViewController *themeSelectionViewController = [[ThemeSelectionViewController alloc] init];
        [self.navigationController pushViewController: themeSelectionViewController animated: YES];
        [themeSelectionViewController release];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"App Appearance", @"App Appearance Header");
    } else if (section == 1) {
        return NSLocalizedString(@"Calculation Settings", @"Calculation Header");
    }
    return nil;
}

#pragma mark - Logic Methods

/// Toggles the state of the rounded total switch to on or off
- (void) roundedTotalSwitchTapped {
    // Update SettingsManager when the switch changes state
    [SettingsManager sharedManager].isRoundedTotalSwitchActive = self.showRoundedValuesSwitch.isOn;
    
    // Post the notification when the switch is toggled to show the new total cell when the modal is dismissed
    [[NSNotificationCenter defaultCenter] postNotificationName: @"RoundedTotalSwitchActivatedNotification" object: nil];
}

- (void) saveTipPercentageSwitchTapped {
    [SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive = self.saveTipPercentageSwitch.isOn;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SaveLastTipPercentageSwitchActivatedNotification" object: nil];
}

/// Dismisses the Settings screen and saves data
- (void) exitButtonPressed {
    [[SettingsManager sharedManager] saveCurrentSettings];
    [self dismissViewControllerAnimated: YES completion: nil];
}


#pragma mark - Dealloc
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [_selectedThemeLabel release];
    [_themeSelectionViewController release];
    [_themeColorLabel release];
    [_navigationBar release];
    [_settingsTableView release];
    [_showRoundedValuesLabel release];
    [_showRoundedValuesSwitch release];
    [_saveTipPercentageLabel release];
    [_saveTipPercentageSwitch release];
    [super dealloc];
}


@end

