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
    self.navigationController.navigationBar.tintColor = [[SettingsManager sharedManager] colorForTheme: [SettingsManager sharedManager].currentTheme];
    self.title = NSLocalizedString(@"Theme Color", @"Theme Color Title");
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

#pragma mark - Life Cycle Methods

- (void)loadView {
    UIView *themeSelectionView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.view = themeSelectionView;
    [themeSelectionView release];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 26.0, *)) {}
    else {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applyTheme:) name: @"ThemeDidChangeNotification" object: nil];
    }
    
    [self setupTableViewUI];
    [self setupThemeSelectionViewController];
}

- (void) applyTheme: (NSNotification *) notification {
    ThemeColorType theme = [[SettingsManager sharedManager] currentTheme];
    self.navigationController.navigationItem.backBarButtonItem.tintColor = [[SettingsManager sharedManager] colorForTheme: theme];
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ColorCell" forIndexPath: indexPath];
    
    NSArray *colors = [[SettingsManager sharedManager] allThemeNames];
    NSString *colorName = colors[indexPath.row];
    ThemeColorType cellTheme = [[SettingsManager sharedManager] themeFromString: colorName];
    UIColor *color = [[SettingsManager sharedManager] colorForTheme: cellTheme];
    
    cell.colorLabel.text = colorName;
    cell.colorCircle.tintColor = color;
    
    if (cellTheme == [SettingsManager sharedManager].currentTheme) {
        cell.checkmark.tintColor = color;
    } else {
        cell.checkmark.tintColor = [UIColor clearColor];
    }
    
    [colors release];
    [colorName release];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.estimatedRowHeight = 85;
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    ColorCell *cell = [tableView cellForRowAtIndexPath: indexPath];

    NSArray *colors = [[SettingsManager sharedManager] allThemeNames];
    NSString *colorName = colors[indexPath.row];
    
    // Get previous color
    ThemeColorType previousTheme = [[SettingsManager sharedManager] currentTheme];
    NSString *previousColorName = [[SettingsManager sharedManager] nameForTheme: previousTheme];
    NSInteger previousRow = [colors indexOfObject: previousColorName];
    
    if (previousRow != NSNotFound) {
        NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow: previousRow inSection: 0];
        ColorCell *previousCell = [self.themeSelectionTableView cellForRowAtIndexPath: previousIndexPath];
        if (indexPath == previousIndexPath) {
            previousCell.checkmark.hidden = NO;
        } else {
            previousCell.checkmark.hidden = YES;
        }
    }
    
    // Get the selected theme and apply it to the selected cell's checkmark
    ThemeColorType selectedTheme = [[SettingsManager sharedManager] themeFromString: colorName];
    
    // Set the app icon to the corrosponding theme
    AppIconType appIcon = [[SettingsManager sharedManager] appIconFromTheme: selectedTheme];
    
    [SettingsManager sharedManager].currentTheme = selectedTheme;
    [self setAlternateAppIcon: appIcon];
    cell.checkmark.tintColor = [[SettingsManager sharedManager] colorForTheme: selectedTheme];
    [[SettingsManager sharedManager] saveCurrentSettings];
    
    [colors release];
    [previousColorName release];
    [colorName release];
}

#pragma mark - App Icon Selection Method
/// Sets the alternate app icon and sends an alert to the user based on the result
- (void) setAlternateAppIcon: (AppIconType) appIcon {
    // Get the icon name
    NSString *appIconName = [[SettingsManager sharedManager] nameForAppIcon: appIcon];
    
    // Set the alternate icon name to the new icon name
    [UIApplication.sharedApplication setAlternateIconName: appIconName completionHandler: ^(NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *appIconErrorAlert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Icon Change Failed", @"Error Message Title")
                                                                                        message: error.localizedDescription
                                                                                        preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {}];
                
                [appIconErrorAlert addAction: defaultAction];
                [self presentViewController: appIconErrorAlert animated: YES completion: ^(){}];
            });
        }
    }];
}


#pragma mark - Dealloc
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [_themeSelectionTableView release];
    [super dealloc];
}

@end
