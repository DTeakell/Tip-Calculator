//
//  ViewController.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "SettingsViewController.h"
#import "TipCalculator.h"
#import "CheckAmountCell.h"
#import "TipPercentageSelectorCell.h"
#import "CustomTipPercentageCell.h"
#import "PersonSelectionCell.h"
#import "TipAmountCell.h"
#import "CurrencyFormatter.h"
#import "TotalAmountCell.h"
#import "SettingsManager.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController


#pragma mark - UI Setup Methods

/// Sets up the view background, navigation title, and bar buttons
- (void) setupNavigationController {
    [self setupHomeViewController];
    [self setupNavigationBarButtons];
}

/// Sets up the ViewController background and navigation title
- (void) setupHomeViewController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = NSLocalizedString(@"Tip Calculator", "Title");
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
}

/// Sets up the buttons on the navigation bar.
- (void) setupNavigationBarButtons {
    
    UIColor *color = [[SettingsManager sharedManager] colorForTheme: [SettingsManager sharedManager].currentTheme];
    
    // Clear Button
    if (@available(iOS 26.0, *)) {
        UIBarButtonItem *clearScreenButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Clear", @"Clear Screen Button") style: UIBarButtonItemStyleProminent target: self action: @selector(clearScreenTapped)];
        
        self.clearScreenButton = clearScreenButtonItem;
        [clearScreenButtonItem release];
        self.clearScreenButton.tintColor = color;
    } else {
        UIBarButtonItem *clearScreenButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Clear", @"Clear Screen Button") style: UIBarButtonItemStylePlain target: self action: @selector(clearScreenTapped)];
        self.clearScreenButton = clearScreenButtonItem;
        [clearScreenButtonItem release];
        self.clearScreenButton.tintColor = color;
    }
    
    // Settings Button
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Settings", @"Settings Button") image: [UIImage systemImageNamed: @"gear"] target: self action: @selector(presentSettingsModal) menu: nil];
    
    if (@available(iOS 26.0, *)) {
        self.settingsButton = settingsButtonItem;
        [settingsButtonItem release];
    } else {
        self.settingsButton = settingsButtonItem;
        [settingsButtonItem release];
        self.settingsButton.tintColor = [UIColor labelColor];
        self.settingsButton.style = UIBarButtonItemStylePlain;
    }
    
    
    self.navigationItem.rightBarButtonItem = self.clearScreenButton;
    self.navigationItem.leftBarButtonItem = self.settingsButton;
}

/// Initializes a TableView and sets up the table view cells
- (void) setupTableViewUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleInsetGrouped];
    self.homeTableView = tableView;
    [tableView release];
    
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    
    self.homeTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.homeTableView];
    
    [self.homeTableView registerClass: [CheckAmountCell class] forCellReuseIdentifier: @"CheckAmountCell"];
    [self.homeTableView registerClass: [TipPercentageSelectorCell class] forCellReuseIdentifier: @"TipPercentageSelectorCell"];
    [self.homeTableView registerClass: [CustomTipPercentageCell class] forCellReuseIdentifier: @"CustomTipPercentageCell"];
    [self.homeTableView registerClass: [PersonSelectionCell class] forCellReuseIdentifier: @"PersonSelectionCell"];
    [self.homeTableView registerClass: [TipAmountCell class] forCellReuseIdentifier: @"TipAmountCell"];
    [self.homeTableView registerClass: [TotalAmountCell class] forCellReuseIdentifier: @"TotalAmountCell"];
}

/// Sets up the entire UI using a collection of UI setup methods.
- (void) setupUI {
    [self setupTableViewUI];
    [self setupNavigationController];
}


#pragma mark - Utility Setup Methods

/// Initializes a new Tip Calculator class instance
- (void) setupTipCalculator {
    TipCalculator *calculator = [[TipCalculator alloc] init];
    self.tipCalculator = calculator;
    [calculator release];
}

/// Initializes a new NSNumberFormatter
- (void) setupNumberFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.numberFormatter = formatter;
    [formatter release];
}

/// Initializes a new array of tip percentages
- (void) setupTipPercentages {
    // Setup the array for tip percentages
    NSArray *tipOptions = [[NSArray alloc] initWithObjects: @0, @10, @15, @20, @0, nil];
    self.tipPercentages = tipOptions;
    
    // Restore from the saved index
    NSInteger restoredIndex = [SettingsManager sharedManager].tipPercentageIndex;
    BOOL shouldRestore = [SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive;
    
    // Clamp to available preset segments (exclude the last slot which is reserved for Custom)
    NSInteger maxPresetIndex = (NSInteger) self.tipPercentages.count - 1;
    NSInteger clampedIndex = 0;
    if (shouldRestore && restoredIndex >= 0 && restoredIndex <= maxPresetIndex) {
        clampedIndex = restoredIndex;
    }
    self.selectedTipIndex = clampedIndex;
    
    // Apply to calculator so values are correct before the cell is created
    NSNumber *selectedTip = self.tipPercentages [self.selectedTipIndex];
    
    // Custom Tip Logic
    if (self.selectedTipIndex == self.tipPercentages.count - 1) {
        self.tipCalculator.tipPercentage = [SettingsManager sharedManager].customTipPercentage;
    } else {
        self.tipCalculator.tipPercentage = [selectedTip doubleValue];
    }

    [tipOptions release];

    // Ensure the table shows the restored index in the segmented control
    [self.homeTableView reloadData];
}

/// Creates a feedback generator to generate haptics for the tip percentage picker
- (void) setupHaptics {
    // Initialize Feedback Generator
    UISelectionFeedbackGenerator *feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    self.tipPercentageFeedbackGenerator = feedbackGenerator;
    [feedbackGenerator release];
    
    [self.tipPercentageFeedbackGenerator prepare];
}

/// Creates a gesture recognizer to recognize when the user taps outside of the keyboard and dismisses the keyboard
- (void) setupGestures {
    // Gesture to dismiss keyboard when screen is tapped
    UITapGestureRecognizer *tapOutsideOfKeyboardGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismissKeyboard)];
    [self.view addGestureRecognizer: tapOutsideOfKeyboardGesture];
    [tapOutsideOfKeyboardGesture release];
}


#pragma mark - Lifecycle Methods

- (void) loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = view;
    [view release];
}

- (void) viewWillAppear: (BOOL) animated {
    
    [super viewWillAppear: animated];
    if ([SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive && [SettingsManager sharedManager].tipPercentageIndex == self.tipPercentages.count - 1) {
        self.isCustomTipEnabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Notification for theme change
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applyTheme:) name: @"ThemeDidChangeNotification" object: nil];
    
    // Notification for rounded total
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(activateRoundedTotal:) name: @"RoundedTotalSwitchActivatedNotification" object: nil];
    
    [self setupTipCalculator];
    
    [self setupNumberFormatter];
    
    [self setupTipPercentages];
    
    [self setupHaptics];
    
    [self setupGestures];
    
    [self setupUI];
}





#pragma mark - Table View Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isCustomTipEnabled ? 6 : 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Check Amount Text Field
    if (indexPath.section == 0) {
        CheckAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CheckAmountCell"];
        self.checkAmountTextField = cell.checkAmountTextField;
        self.checkAmountValue = cell.checkAmountTextField.text;
        self.checkAmountTextField.enabled = YES;
        [self.checkAmountTextField addTarget: self action: @selector(inputChanged) forControlEvents: UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell applyTheme];
        return cell;
    }
    

    // Tip Percentage Segmented Control
    else if (indexPath.section == 1) {
        TipPercentageSelectorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TipPercentageSelectorCell"];
        self.tipPercentageSelector = cell.tipPercentageSelector;
        self.tipPercentageSelector.selectedSegmentIndex = self.selectedTipIndex;
        [self.tipPercentageSelector addTarget: self action: @selector(segmentChanged:) forControlEvents: UIControlEventValueChanged];
        [cell applyTheme];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    

    // Custom Tip Percentage Text Field
    else if (self.isCustomTipEnabled && indexPath.section == 2) {
        CustomTipPercentageCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CustomTipPercentageCell"];
        self.customTipPercentageTextField = cell.customTipPercentageTextField;
        
        if ([SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive) {
            double initialTipPercentage = [SettingsManager sharedManager].customTipPercentage;
            NSString *tipPercentageString = [NSString stringWithFormat: @"%.0f", initialTipPercentage];
            self.customTipPercentageValue = tipPercentageString;
            self.customTipPercentageTextField.text = self.customTipPercentageValue;
            
        } else {
            self.customTipPercentageValue = cell.customTipPercentageTextField.text;
        }
        
        [self.customTipPercentageTextField addTarget: self action: @selector(customTipChanged) forControlEvents: UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell applyTheme];
        
        return cell;
    }
    

    // Person Selection Text Field
    else if (indexPath.section == 2 || (self.isCustomTipEnabled && indexPath.section == 3 )) {
        PersonSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier: @"PersonSelectionCell"];
        self.numberOfPeopleTextField = cell.numberOfPeopleTextField;
        self.numberOfPeopleValue = cell.numberOfPeopleTextField.text;
        [self.numberOfPeopleTextField addTarget: self action: @selector(inputChanged) forControlEvents: UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell applyTheme];
        return cell;
    }
    

    // Tip Amount Label
    else if (indexPath.section == 3 || (self.isCustomTipEnabled && indexPath.section == 4)) {
        TipAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TipAmountCell"];
        self.tipAmountLabel = cell.tipAmountLabel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    // Total Amount Label
    } else if (indexPath.section == 4 || (self.isCustomTipEnabled && indexPath.section == 5)) {
        TotalAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TotalAmountCell"];
        [cell configureWithRoundedTotalActive: [SettingsManager sharedManager].isRoundedTotalSwitchActive];
        [cell applyTheme];
        self.roundedCheckTotalLabel = cell.roundedTotalLabel;
        self.checkTotalLabel = cell.checkTotalLabel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

// Customize headers
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return NSLocalizedString(@"Check Amount", @"Check Amount Title");
    } else if (section == 1) {
        return NSLocalizedString(@"Tip Percentage", @"Tip Percentage Title");
    } else if (self.isCustomTipEnabled && section == 2) {
        return NSLocalizedString(@"Custom Tip Percentage", @"Custom Tip Percentage Title");
    } else if (section == 2 || (self.isCustomTipEnabled && section == 3)) {
        return NSLocalizedString(@"Number of People", @"Number of People on Check");
    } else if (section == 3 || (self.isCustomTipEnabled && section == 4)) {
        return NSLocalizedString(@"Tip Amount", @"Tip Amount Title");
    } else if (section == 4 || (self.isCustomTipEnabled && section == 5)) {
        return NSLocalizedString(@"Total Amount", @"Total Amount Title");
    }
    return nil;
}


#pragma mark - View Methods

/// Shows the 'Settings' screen to the user when settings button is tapped
- (void) presentSettingsModal {
    SettingsViewController *settingsModalViewController = [[[SettingsViewController alloc] init] autorelease];
    UINavigationController *settingsNavigationController = [[[UINavigationController alloc] initWithRootViewController: settingsModalViewController] autorelease];
    
    settingsNavigationController.modalPresentationStyle = UIModalPresentationAutomatic;
    [self.navigationController presentViewController: settingsNavigationController animated: YES completion: nil];
}

- (void) applyTheme: (NSNotification *) notification {
    ThemeColorType theme = [[SettingsManager sharedManager] currentTheme];
    UIColor *color = [[SettingsManager sharedManager] colorForTheme: theme];
    
    self.navigationItem.rightBarButtonItem.tintColor = color;
    self.checkAmountTextField.tintColor = color;
    self.checkTotalLabel.tintColor = color;
    self.tipPercentageSelector.tintColor = color;
    self.tipPercentageSelector.selectedSegmentTintColor = color;
    self.customTipPercentageTextField.tintColor = color;
    self.numberOfPeopleTextField.tintColor = color;
    
    // Go through and apply the theme to all cells
    for (UITableViewCell *cell in self.homeTableView.visibleCells) {
        if ([cell respondsToSelector: @selector(applyTheme)]) {
            [(id) cell applyTheme];
        }
    }
    
    [self.homeTableView beginUpdates];
    [self.homeTableView endUpdates];
    
}


/// Applies the rounded total configuration to the `TotalAmountCell`
- (void) activateRoundedTotal: (NSNotification *) notification {
    // Update the cell’s rounded-toggle appearance
    BOOL roundedActive = [SettingsManager sharedManager].isRoundedTotalSwitchActive;
    
    // Find the TotalAmountCell, and when found, apply the configuration
    for (UITableViewCell *cell in self.homeTableView.visibleCells) {
        if ([cell isKindOfClass:[TotalAmountCell class]]) {
            TotalAmountCell *totalCell = (TotalAmountCell *)cell;
            [totalCell configureWithRoundedTotalActive:roundedActive];
            break;
        }
    }

    // Recompute labels to reflect the new setting immediately
    [self inputChanged];

    // Since the heights change, the tableView will need to update the cell height respectively.
    [UIView performWithoutAnimation:^{
        [self.homeTableView beginUpdates];
        [self.homeTableView endUpdates];
    }];
}


/// Clears inputs and resets calculated labels
- (void) clearScreenTapped {
    [self.tipCalculator reset];
    
    // Clear text fields
    self.checkAmountTextField.text = @"";
    self.customTipPercentageTextField.text = @"";
    self.numberOfPeopleTextField.text = @"";
    
    BOOL wasCustom = self.isCustomTipEnabled;

    // Reset calculator values
    [self.homeTableView beginUpdates];
    self.tipPercentageSelector.selectedSegmentIndex = 0;
    self.selectedTipIndex = 0;
    self.isCustomTipEnabled = NO;
    self.tipCalculator.checkAmount = 0.0;
    self.tipCalculator.tipPercentage = 0.0;
    self.tipCalculator.numberOfPeopleOnCheck = 0.0;
    
    if (wasCustom && !self.isCustomTipEnabled) {
        [self.homeTableView deleteSections: [NSIndexSet indexSetWithIndex: 2] withRowAnimation: UITableViewRowAnimationFade];
    }
    
    [self.homeTableView endUpdates];
    
    [self inputChanged];
    
    // Clear the tip and check labels
    self.tipAmountLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
}


/// Dismisses the keyboard when the user taps off of the keyboard.
- (void) dismissKeyboard {
    [self.view endEditing: YES];
}



# pragma mark - Input Handling Methods

/// Updates the tip value based on the selected tip percentage segment
- (void) segmentChanged: (UISegmentedControl *)sender {
    self.selectedTipIndex = sender.selectedSegmentIndex;
    
    // Trigger haptics on change
    [self.tipPercentageFeedbackGenerator selectionChanged];
    [self.tipPercentageFeedbackGenerator prepare];
    
    // Stores the current state of 'isCustomTipEnabled' before it gets updated
    BOOL wasCustom = self.isCustomTipEnabled;
    
    // Updates the flag when the selected tip is custom
    self.isCustomTipEnabled = (self.selectedTipIndex == self.tipPercentages.count - 1);
    
    // Create or delete row based on if the custom tip is enabled.
    if (!wasCustom && self.isCustomTipEnabled) {
        [self.homeTableView beginUpdates];
        [self.homeTableView insertSections: [NSIndexSet indexSetWithIndex: 2] withRowAnimation: UITableViewRowAnimationFade];
        [self.homeTableView endUpdates];
    } else if (wasCustom && !self.isCustomTipEnabled) {
        [self.homeTableView beginUpdates];
        [self.homeTableView deleteSections: [NSIndexSet indexSetWithIndex: 2] withRowAnimation: UITableViewRowAnimationFade];
        [self.homeTableView endUpdates];
    }
    
    // Recalculate tip
    [self customTipChanged];
    
    // When the custom tip isn't enabled, carry out normal calculation
    if (!self.isCustomTipEnabled) {
        NSNumber *selectedTip = self.tipPercentages[self.selectedTipIndex];
        self.tipCalculator.tipPercentage = [selectedTip doubleValue];
        [self inputChanged];
    }
    
    // Save tip percentage if the switch is toggled and custom tip is disabled
    if ([SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive && !self.isCustomTipEnabled) {
        [SettingsManager sharedManager].tipPercentageIndex = self.selectedTipIndex;
        [[SettingsManager sharedManager] saveCurrentSettings];
    } else if ([SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive && self.isCustomTipEnabled) {
        [SettingsManager sharedManager].tipPercentageIndex = self.selectedTipIndex;
        [SettingsManager sharedManager].customTipPercentage = [self.customTipPercentageValue doubleValue];
        [[SettingsManager sharedManager] saveCurrentSettings];
    }
}

/// Calculates the tip of the check with a custom tip percentage
- (void) customTipChanged {
    double customTip = [self.customTipPercentageTextField.text doubleValue];
    self.tipCalculator.tipPercentage = customTip;
    
    if ([SettingsManager sharedManager].isSaveLastTipPercentageSwitchActive) {
        [SettingsManager sharedManager].customTipPercentage = customTip;
        [[SettingsManager sharedManager] saveCurrentSettings];
    }
    
    [self inputChanged];
}


///  Calculates the tip and total of the check when any input changes (eg. Check amount changes, tip percentage changes, etc.)
- (void) inputChanged {
    
    // Creates an NSNumber from the string and sets it equal to the user input value
    NSNumber *checkNumber = [self.numberFormatter numberFromString: self.checkAmountTextField.text];
    
    // Sets the check value based on the NSNumber and gets the double value from it
    double check = [checkNumber doubleValue];
    double numberOfPeople = [self.numberOfPeopleTextField.text doubleValue];
    
    self.tipCalculator.checkAmount = check;
    self.tipCalculator.numberOfPeopleOnCheck = numberOfPeople;
    
    if (numberOfPeople > 1) {
        double tipPerPerson = [self.tipCalculator calculateTipWithMultiplePeople];
        double totalPerPerson = [self.tipCalculator calculateTotalWithMultiplePeople];
        double roundedTotalPerPerson = [self.tipCalculator roundUp: totalPerPerson];
        
        self.tipAmountLabel.text = [CurrencyFormatter localizedPerPersonStringFromDouble: tipPerPerson];
        self.checkTotalLabel.text = [CurrencyFormatter localizedPerPersonStringFromDouble: totalPerPerson];
        self.roundedCheckTotalLabel.text = [CurrencyFormatter localizedPerPersonStringFromDouble: roundedTotalPerPerson];
        
        // Accessibility Labels
        self.tipAmountLabel.accessibilityLabel = NSLocalizedString(@"Tip Amount", @"Accessibility Label for Tip");
        self.tipAmountLabel.accessibilityValue = [CurrencyFormatter localizedPerPersonStringFromDouble: tipPerPerson];
        
        self.checkTotalLabel.accessibilityLabel = NSLocalizedString(@"Total Amount", @"Accessibility Label for Total");
        self.checkTotalLabel.accessibilityValue = [CurrencyFormatter localizedPerPersonStringFromDouble: totalPerPerson];
        
    } else {
        double tip = [self.tipCalculator calculateTip];
        double total = [self.tipCalculator calculateTotal];
        double roundedTotal = [self.tipCalculator roundUp: total];
        
        self.tipAmountLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: tip];
        self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: total];
        self.roundedCheckTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: roundedTotal];
        
        self.tipAmountLabel.accessibilityLabel = NSLocalizedString(@"Tip Amount", @"Accessibility Label for Tip");
        self.tipAmountLabel.accessibilityValue = [CurrencyFormatter localizedCurrencyStringFromDouble: tip];
        
        self.checkTotalLabel.accessibilityLabel = NSLocalizedString(@"Total Amount", @"Accessibility Label for Total");
        self.checkTotalLabel.accessibilityValue = [CurrencyFormatter localizedCurrencyStringFromDouble: total];
    }
}

#pragma mark - Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [_roundedCheckTotalLabel release];
    [_homeTableView release];
    [_checkAmountTextField release];
    [_tipPercentageSelector release];
    [_tipPercentages release];
    [_customTipPercentageTextField release];
    [_tipPercentageFeedbackGenerator release];
    [_numberOfPeopleTextField release];
    [_tipAmountLabel release];
    [_checkTotalLabel release];
    [_tipCalculator release];
    [_numberFormatter release];
    [_clearScreenButton release];
    [_settingsViewController release];
    [_settingsButton release];
    [super dealloc];
}

@end
