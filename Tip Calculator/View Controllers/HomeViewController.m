//
//  ViewController.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

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

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController


#pragma mark - UI Setup Methods

/// Sets up the view background, navigation title, and bar buttons
- (void) setupNavigationController {
    [self setupHomeViewController];
    [self setupNavigationBarButtons];
}


- (void) setupHomeViewController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = NSLocalizedString(@"Tip Calculator", "Title");
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
}

/// Sets up the buttons on the navigation bar.
- (void) setupNavigationBarButtons {
    
    // iOS 26 Liquid Glass style
    // Sets up 'Clear' button
    if (@available(iOS 26.0, *)) {
        UIBarButtonItem *clearScreenButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage systemImageNamed: @"arrow.counterclockwise"] style: UIBarButtonItemStyleProminent target: self action: @selector(clearScreenTapped)];
        self.clearScreenButton = clearScreenButtonItem;
        [clearScreenButtonItem release];
    } else {
        UIBarButtonItem *clearScreenButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage systemImageNamed: @"arrow.counterclockwise"] style: UIBarButtonItemStylePlain target: self action: @selector(clearScreenTapped)];
        self.clearScreenButton = clearScreenButtonItem;
        [clearScreenButtonItem release];
        self.clearScreenButton.tintColor = [UIColor colorNamed: @"AccentColor"];
    }
    
    // Sets up 'Settings' button
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Settings", @"Settings Button") image: [UIImage systemImageNamed: @"gear"] target: self action: @selector(presentSettingsModal) menu: nil];
    
    if (@available(iOS 26.0, *)) {
        self.settingsButton = settingsButtonItem;
        [settingsButtonItem release];
    } else {
        self.settingsButton = settingsButtonItem;
        [settingsButtonItem release];
        self.settingsButton.tintColor = [UIColor labelColor];
    }
    
    
    self.navigationItem.rightBarButtonItem = self.clearScreenButton;
    self.navigationItem.leftBarButtonItem = self.settingsButton;
}

/// Initializes a TableView and sets up the table view cells
- (void) setupTableViewUI {
    self.tableView = [[[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleInsetGrouped] autorelease];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.tableView];
    
    [self.tableView registerClass: [CheckAmountCell class] forCellReuseIdentifier: @"CheckAmountCell"];
    [self.tableView registerClass: [TipPercentageSelectorCell class] forCellReuseIdentifier: @"TipPercentageSelectorCell"];
    [self.tableView registerClass: [CustomTipPercentageCell class] forCellReuseIdentifier: @"CustomTipPercentageCell"];
    [self.tableView registerClass: [PersonSelectionCell class] forCellReuseIdentifier: @"PersonSelectionCell"];
    [self.tableView registerClass: [TipAmountCell class] forCellReuseIdentifier: @"TipAmountCell"];
    [self.tableView registerClass: [TotalAmountCell class] forCellReuseIdentifier: @"TotalAmountCell"];
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
    self.selectedTipIndex = 0;
    [tipOptions release];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTipCalculator];
    
    [self setupNumberFormatter];
    
    [self setupTipPercentages];
    
    [self setupHaptics];
    
    [self setupGestures];
    
    [self setupUI];
}



#pragma mark - Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isCustomTipEnabled ? 6 : 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    
    // Set up TableView cells
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        while ([cell.contentView.subviews count] > 0) {
            [[[cell.contentView subviews] lastObject] removeFromSuperview];
        }
    }
    
#pragma mark - Check Amount Text Field
    // Check Amount Text Field
    if (indexPath.section == 0) {
        CheckAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CheckAmountCell"];
        self.checkAmountTextField = cell.checkAmountTextField;
        self.checkAmountTextField.enabled = YES;
        [self.checkAmountTextField addTarget: self action: @selector(inputChanged) forControlEvents: UIControlEventEditingChanged];
        return cell;
    }
    
#pragma mark - Segmented Control
    // Tip Percentage Segmented Control
    else if (indexPath.section == 1) {
        TipPercentageSelectorCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TipPercentageSelectorCell"];
        self.tipPercentageSelector = cell.tipPercentageSelector;
        self.tipPercentageSelector.selectedSegmentIndex = self.selectedTipIndex;
        [self.tipPercentageSelector addTarget: self action: @selector(segmentChanged:) forControlEvents: UIControlEventValueChanged];
        return cell;
    }
    
#pragma mark - Custom Tip Percentage Text Field
    // Custom Tip Percentage Text Field
    else if (self.isCustomTipEnabled && indexPath.section == 2) {
        CustomTipPercentageCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CustomTipPercentageCell"];
        self.customTipPercentageTextField = cell.customTipPercentageTextField;
        
        [self.customTipPercentageTextField addTarget: self action: @selector(customTipChanged) forControlEvents: UIControlEventEditingChanged];
        
        return cell;
    }
    
#pragma mark - Person Selection Text Field
    // Person Selection Text Field
    else if (indexPath.section == 2 || (self.isCustomTipEnabled && indexPath.section == 3 )) {
        PersonSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier: @"PersonSelectionCell"];
        self.numberOfPeopleTextField = cell.numberOfPeopleTextField;
        [self.numberOfPeopleTextField addTarget: self action: @selector(inputChanged) forControlEvents: UIControlEventEditingChanged];
        return cell;
    }
    
#pragma mark - Tip Amount Label
    // Tip Amount Label
    else if (indexPath.section == 3 || (self.isCustomTipEnabled && indexPath.section == 4)) {
        TipAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TipAmountCell"];
        self.tipAmountLabel = cell.tipAmountLabel;
        return cell;
        
        
#pragma mark - Total Amount Label
        // Total Amount Label
    } else if (indexPath.section == 4 || (self.isCustomTipEnabled && indexPath.section == 5)) {
        TotalAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TotalAmountCell"];
        self.checkTotalLabel = cell.checkTotalLabel;
        return cell;
    }
    
    return cell;
    
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
    
    [self.navigationController presentViewController: settingsModalViewController animated: YES completion: nil];
    settingsModalViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
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
    [self.tableView beginUpdates];
    self.tipPercentageSelector.selectedSegmentIndex = 0;
    self.selectedTipIndex = 0;
    self.isCustomTipEnabled = NO;
    self.tipCalculator.checkAmount = 0.0;
    self.tipCalculator.tipPercentage = 0.0;
    self.tipCalculator.numberOfPeopleOnCheck = 0.0;
    
    if (wasCustom && !self.isCustomTipEnabled) {
        [self.tableView deleteSections: [NSIndexSet indexSetWithIndex: 2] withRowAnimation: UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
    
    [self inputChanged];
    
    // Clear the tip and check labels
    self.tipAmountLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
}


/// Dismisses the keyboard when the user taps off of the keyboard.
- (void) dismissKeyboard {
    [self.view endEditing: YES];
}

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
        [self.tableView beginUpdates];
        [self.tableView insertSections: [NSIndexSet indexSetWithIndex: 2] withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    } else if (wasCustom && !self.isCustomTipEnabled) {
        [self.tableView beginUpdates];
        [self.tableView deleteSections: [NSIndexSet indexSetWithIndex: 2] withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    // Recalculate tip
    [self customTipChanged];
    
    // When the custom tip isn't enabled, carry out normal calculation
    if (!self.isCustomTipEnabled) {
        NSNumber *selectedTip = self.tipPercentages[self.selectedTipIndex];
        self.tipCalculator.tipPercentage = [selectedTip doubleValue];
        [self inputChanged];
    }
}


# pragma mark - Input Handling Methods

/// Calculates the tip of the check with a custom tip percentage
- (void) customTipChanged {
    double customTip = [self.customTipPercentageTextField.text doubleValue];
    self.tipCalculator.tipPercentage = customTip;
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
        
        self.tipAmountLabel.text = [CurrencyFormatter localizedPerPersonStringFromDouble: tipPerPerson];
        self.checkTotalLabel.text = [CurrencyFormatter localizedPerPersonStringFromDouble: totalPerPerson];
        
        // Accessibility Labels
        self.tipAmountLabel.accessibilityLabel = NSLocalizedString(@"Tip Amount", @"Accessibility Label for Tip");
        self.tipAmountLabel.accessibilityValue = [CurrencyFormatter localizedPerPersonStringFromDouble: tipPerPerson];
        
        self.checkTotalLabel.accessibilityLabel = NSLocalizedString(@"Total Amount", @"Accessibility Label for Total");
        self.checkTotalLabel.accessibilityValue = [CurrencyFormatter localizedPerPersonStringFromDouble: totalPerPerson];
        
    } else {
        double tip = [self.tipCalculator calculateTip];
        double total = [self.tipCalculator calculateTotal];
        
        self.tipAmountLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: tip];
        self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: total];
        
        self.tipAmountLabel.accessibilityLabel = NSLocalizedString(@"Tip Amount", @"Accessibility Label for Tip");
        self.tipAmountLabel.accessibilityValue = [CurrencyFormatter localizedCurrencyStringFromDouble: tip];
        
        self.checkTotalLabel.accessibilityLabel = NSLocalizedString(@"Total Amount", @"Accessibility Label for Total");
        self.checkTotalLabel.accessibilityValue = [CurrencyFormatter localizedCurrencyStringFromDouble: total];
    }
}


#pragma mark - Dealloc

- (void)dealloc {
    [_tableView release];
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
    [_settingsButton release];
    [super dealloc];
}

@end
