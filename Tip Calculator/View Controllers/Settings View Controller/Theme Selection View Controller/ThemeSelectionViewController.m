//
//  ThemeSelectionViewController.m
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import "ThemeSelectionViewController.h"
#import "SettingsManager.h"
#import "ColorCell.h"

@implementation ThemeSelectionViewController

#pragma mark - UI Setup Methods

- (void) setupThemeSelectionViewController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = @"Theme Color";
}


- (void) setupTableViewUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleInsetGrouped];
    self.themeSelectionTableView = tableView;
    [tableView release];
    
    self.themeSelectionTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.themeSelectionTableView.delegate = self;
    self.themeSelectionTableView.dataSource = self;
    
    self.themeSelectionTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.themeSelectionTableView registerClass: [ColorCell class] forCellReuseIdentifier: @"ColorCell"];
    [self.view addSubview: self.themeSelectionTableView];
    
    // Constraints
    [NSLayoutConstraint activateConstraints: @[
       [self.themeSelectionTableView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
       [self.themeSelectionTableView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
       [self.themeSelectionTableView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
       [self.themeSelectionTableView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
    
}

-(void) applyTheme: (NSNotification *) notification {
    
}



#pragma mark - Life Cycle Methods

- (void)loadView {
    UIView *themeSelectionView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.view = themeSelectionView;
    [themeSelectionView release];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applyTheme:) name: @"ThemeDidChangeNotification" object: nil];
    [self setupTableViewUI];
    [self setupThemeSelectionViewController];
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ColorCell" forIndexPath: indexPath];
    
    NSArray *colors = [[SettingsManager sharedManager] allThemeNames];
    NSString *colorName = colors[indexPath.row];
    cell.colorLabel.text = colorName;
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [[[SettingsManager sharedManager] allThemeNames] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *colors = [[SettingsManager sharedManager] allThemeNames];
    NSString *colorName = colors[indexPath.row];
    
    ThemeColorType selectedTheme = [[SettingsManager sharedManager] themeFromString: colorName];
    
    [SettingsManager sharedManager].currentTheme = selectedTheme;
    
    [[SettingsManager sharedManager] saveCurrentTheme];
}


#pragma mark - Dealloc
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [_themeSelectionTableView release];
    [super dealloc];
}

@end
