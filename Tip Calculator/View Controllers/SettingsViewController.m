//
//  SettingsViewController.m
//  Tip
//
//  Created by Dillon Teakell on 10/25/25.
//

#import "SettingsViewController.h"
#import "AccentColorCell.h"
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
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self setupTableViewUI];
    [self setupNavigationBar];
    
    
}



#pragma mark - UI Setup Methods

- (void) setupTableViewUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectZero style: UITableViewStyleInsetGrouped];
    self.settingsTableView = tableView;
    [tableView release];
    
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    
    self.settingsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.settingsTableView];
    
    [self.settingsTableView registerClass: [AccentColorCell class] forCellReuseIdentifier: @"AccentColorCell"];
    
    UILayoutGuide *layoutGuide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [tableView.topAnchor constraintEqualToAnchor: layoutGuide.topAnchor constant: 100],
        [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

/// Sets up the navigation bar for the modal view
- (void) setupNavigationBar {
    self.navigationBar = [[[UINavigationBar alloc] init] autorelease];
    self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    
    // Set up navigation bar and buttons
    UINavigationItem *navigationItem = [[[UINavigationItem alloc] initWithTitle: NSLocalizedString(@"Settings", @"Settings Title")] autorelease];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone  target: self action: @selector(doneButtonPressed)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector(cancelButtonPressed)];
    
    navigationItem.leftBarButtonItem = cancelButton;
    navigationItem.rightBarButtonItem = doneButton;
    [cancelButton release];
    [doneButton release];
    
    [self.navigationBar setItems: @[navigationItem]];
    
    [self.view addSubview: self.navigationBar];
    
    // Set constraints for both iOS versions
    if (@available(iOS 26.0, *)) {
        UILayoutGuide *layoutGuide = self.view.safeAreaLayoutGuide;
        [NSLayoutConstraint activateConstraints: @[
            [self.navigationBar.topAnchor constraintEqualToAnchor: layoutGuide.topAnchor constant: 12.5],
            [self.navigationBar.leadingAnchor constraintEqualToAnchor: layoutGuide.leadingAnchor],
            [self.navigationBar.trailingAnchor constraintEqualToAnchor: layoutGuide.trailingAnchor]
        ]];
    } else {
        UILayoutGuide *layoutGuide = self.view.safeAreaLayoutGuide;
        [NSLayoutConstraint activateConstraints: @[
            [self.navigationBar.topAnchor constraintEqualToAnchor: layoutGuide.topAnchor constant: 12.5],
            [self.navigationBar.leadingAnchor constraintEqualToAnchor: layoutGuide.leadingAnchor constant: 7.5],
            [self.navigationBar.trailingAnchor constraintEqualToAnchor: layoutGuide.trailingAnchor]
        ]];
    }
}



# pragma mark - Table View Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    
    if (indexPath.section == 0) {
        AccentColorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"AccentColorCell"];
        self.accentColorMenuLabel = cell.accentColorLabel;
        return cell;
    }
    
    return cell;
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
    [_accentColorMenu release];
    [_accentColorMenuLabel release];
    [_appIcon release];
    [_appIconMenuLabel release];
    [_navigationBar release];
    [_settingsTableView release];
    [_showRoundedValuesLabel release];
    [_showRoundedValuesSwitch release];
    [super dealloc];
}


@end

