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
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone  target: self action: nil];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: nil];
    
    navigationItem.leftBarButtonItem = cancelButton;
    navigationItem.rightBarButtonItem = doneButton;
    [cancelButton release];
    [doneButton release];
    
    [self.navigationBar setItems: @[navigationItem]];
    
    [self.view addSubview: self.navigationBar];
    
    // Set constraints
    UILayoutGuide *layoutGuide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints: @[
        [self.navigationBar.topAnchor constraintEqualToAnchor: layoutGuide.topAnchor constant: 12.5],
        [self.navigationBar.leadingAnchor constraintEqualToAnchor: layoutGuide.leadingAnchor],
        [self.navigationBar.trailingAnchor constraintEqualToAnchor: layoutGuide.trailingAnchor]
    ]];
}

//TODO: Set up button functions


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

@end

