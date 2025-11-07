//
//  SettingsViewController.m
//  Tip
//
//  Created by Dillon Teakell on 10/25/25.
//

#import "SettingsViewController.h"
#import "ThemeColorCell.h"
#import "ThemeSelectionViewController.h"
#import "AppIconCell.h"
#import "AppIconViewController.h"
#import "ShowRoundedTotalsCell.h"
#import "SaveTipPercentageCell.h"

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
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone  target: self action: @selector(doneButtonPressed)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector(cancelButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [cancelButton release];
    [doneButton release];
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
    [self.settingsTableView registerClass: [AppIconCell class] forCellReuseIdentifier: @"AppIconCell"];
    [self.settingsTableView registerClass: [ShowRoundedTotalsCell class] forCellReuseIdentifier: @"ShowRoundedTotalsCell"];
    [self.settingsTableView registerClass: [SaveTipPercentageCell class] forCellReuseIdentifier: @"SaveTipPercentageCell"];
    
    [NSLayoutConstraint activateConstraints:@[
        [tableView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}



# pragma mark - Table View Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.estimatedRowHeight = 85;
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        while ([cell.contentView.subviews count] > 0) {
            [[[cell.contentView subviews] lastObject] removeFromSuperview];
        }
    }
    
    //MARK: Theme Color Cell
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeColorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ThemeColorCell"];
        self.themeColorLabel = cell.themeColorLabel;
        return cell;
    }
    
    //MARK: App Icon Selection Cell
    if (indexPath.section == 0 && indexPath.row == 1) {
        AppIconCell *cell = [tableView dequeueReusableCellWithIdentifier: @"AppIconCell"];
        self.appIconMenuLabel = cell.appIconLabel;
        return cell;
    }
    
    //MARK: Show Rounded Totals Cell
    if (indexPath.section == 1) {
        ShowRoundedTotalsCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ShowRoundedTotalsCell"];
        self.showRoundedValuesLabel = cell.showRoundedTotalsLabel;
        return cell;
    }
    
    //MARK: Save Tip Percentage Selection Cell
    if (indexPath.section == 2) {
        SaveTipPercentageCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SaveTipPercentageCell"];
        self.saveTipPercentageLabel = cell.savePercentageLabel;
        return cell;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeSelectionViewController *themeSelectionViewController = [[ThemeSelectionViewController alloc] init];
        [self.navigationController pushViewController: themeSelectionViewController animated: YES];
        [themeSelectionViewController release];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        AppIconViewController *appIconViewController = [[AppIconViewController alloc] init];
        [self.navigationController pushViewController: appIconViewController animated: YES];
        [appIconViewController release];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"App Customization";
    }
    return nil;
}


#pragma mark - Logic Methods
/// Saves the user's data and dismisses the Settings screen
- (void) doneButtonPressed {
    //TODO: Save user data
    [self dismissViewControllerAnimated: YES completion: nil];
}

/// Dismisses the Settings screen without saving any data
- (void) cancelButtonPressed {
    [self dismissViewControllerAnimated: YES completion: nil];
}


#pragma mark - Dealloc
- (void) dealloc {
    [_themeSelectionViewController release];
    [_themeColorLabel release];
    [_appIcon release];
    [_appIconMenuLabel release];
    [_appIconSelectionViewController release];
    [_navigationBar release];
    [_settingsTableView release];
    [_showRoundedValuesLabel release];
    [_showRoundedValuesSwitch release];
    [_saveTipPercentageLabel release];
    [_saveTipPercentageSwitch release];
    [super dealloc];
}


@end

