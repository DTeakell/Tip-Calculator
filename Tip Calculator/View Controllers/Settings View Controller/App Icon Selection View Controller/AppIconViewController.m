//
//  AppIconViewController.m
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import "AppIconViewController.h"
#import "SettingsManager.h"
#import "AppIconCell.h"

@implementation AppIconViewController


#pragma mark - UI Setup Methods

- (void) setupAppIconViewController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.navigationController.navigationBar.tintColor = [[SettingsManager sharedManager] colorForTheme: [SettingsManager sharedManager].currentTheme];
    self.title = NSLocalizedString(@"App Icon", @"App Icon View Title");
}

- (void) setupTableViewUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleInsetGrouped];
    self.appIconTableView = tableView;
    [tableView release];
    
    self.appIconTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.appIconTableView.delegate = self;
    self.appIconTableView.dataSource = self;
    
    self.appIconTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.appIconTableView];
    
    // Constraints
    [NSLayoutConstraint activateConstraints: @[
        [self.appIconTableView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.appIconTableView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.appIconTableView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.appIconTableView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
}


#pragma mark - Life Cycle Methods
- (void) loadView {
    UIView *appIconView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.view = appIconView;
    [appIconView release];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableViewUI];
    [self setupAppIconViewController];
    
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppIconCell *cell = [tableView dequeueReusableCellWithIdentifier: @"AppIconCell"];
    return cell;
}


#pragma mark - Dealloc
- (void) dealloc {
    [super dealloc];
}

@end
