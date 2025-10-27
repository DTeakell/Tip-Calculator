//
//  SettingsViewController.m
//  Tip
//
//  Created by Dillon Teakell on 10/25/25.
//

#import "SettingsViewController.h"
#import <UIKit/UIKit.h>

@implementation SettingsViewController

#pragma mark - UI Setup Methods

//TODO: Set up UI for initial settings


- (void) setupNavigationBar {
    // Set up navigation bar
    self.navigationBar = [[[UINavigationBar alloc] init] autorelease];
    self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationBar.prefersLargeTitles = YES;
    
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

#pragma mark - Life cycle Methods

- (void) loadView {
    UIView *modalView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = modalView;
    [modalView release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self setupNavigationBar];
    
}

//TODO: Set up button functions
#pragma mark - Logic Methods
/// Saves the user's data and dismisses the Settings screen
- (void) doneButtonPressed {
    [self dismissViewControllerAnimated: YES completion: nil];
}

/// Dismisses the Settings screen without saving any data
- (void) cancelButtonPressed {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end

