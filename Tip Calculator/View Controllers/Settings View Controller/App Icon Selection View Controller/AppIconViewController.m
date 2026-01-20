//
//  AppIconViewController.m
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import "AppIconViewController.h"
#import "SettingsManager.h"
#import "AppIconColorCell.h"

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
    
    
    [self.appIconTableView registerClass: [AppIconColorCell class] forCellReuseIdentifier: @"AppIconColorCell"];
    [self.view addSubview: self.appIconTableView];
    
    // Constraints
    [NSLayoutConstraint activateConstraints: @[
        [self.appIconTableView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.appIconTableView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.appIconTableView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.appIconTableView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
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
    return 12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppIconColorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"AppIconColorCell" forIndexPath: indexPath];
    
    NSArray *colors = [[SettingsManager sharedManager] allThemeNames];
    NSString *colorName = colors[indexPath.row];
    UIColor *currentThemeColor = [[SettingsManager sharedManager] colorForTheme: [SettingsManager sharedManager].currentTheme];
    
    if (indexPath.row == 0) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Red.png"];
    } else if (indexPath.row == 1) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon.png"];
    } else if (indexPath.row == 2) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Yellow.png"];
    } else if (indexPath.row == 3) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Green.png"];
    } else if (indexPath.row == 4) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Mint.png"];
    } else if (indexPath.row == 5) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Teal.png"];
    } else if (indexPath.row == 6) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Cyan.png"];
    } else if (indexPath.row == 7) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Blue.png"];
    } else if (indexPath.row == 8) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Indigo.png"];
    } else if (indexPath.row == 9) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Purple.png"];
    } else if (indexPath.row == 10) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Pink.png"];
    } else if (indexPath.row == 11) {
        cell.appIconImage.image = [UIImage imageNamed: @"AppIcon-Gray.png"];
    }
    
    cell.colorLabel.text = colorName;
    cell.checkmark.tintColor = currentThemeColor;
    
    [colors release];
    [colorName release];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    // Get theme colors
    NSArray *colors = [[SettingsManager sharedManager] allThemeNames];
    NSString *colorName = colors[indexPath.row];
    ThemeColorType cellTheme = [[SettingsManager sharedManager] themeFromString: colorName];
    
    AppIconType cellIcon = [[SettingsManager sharedManager] appIconFromTheme: cellTheme];
    
    [colors release];
    [colorName release];
    
    [self setAlternateAppIcon: cellIcon];
}


#pragma mark - Dealloc
- (void) dealloc {
    [_appIconTableView release];
    [super dealloc];
}

@end
