//
//  ViewController.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import "ViewController.h"
#import "TipCalculator.h"
#import "CheckAmountCell.h"
#import "TipPercentageSelectorCell.h"
#import "CustomTipPercentageCell.h"
#import "PersonSelectionCell.h"
#import "TipAmountCell.h"
#import "CurrencyFormatter.h"
#import "TotalAmountCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

// Utilities
@property (nonatomic, retain) TipCalculator *tipCalculator;
@property (nonatomic, retain) UISelectionFeedbackGenerator *tipPercentageFeedbackGenerator;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;

// UI Properties
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextField *checkAmountTextField;
@property (nonatomic, retain) UIBarButtonItem *clearScreenButton;
@property (nonatomic, retain) UILabel *tipAmountLabel;
@property (nonatomic, retain) UILabel *checkTotalLabel;
@property (nonatomic, retain) UISegmentedControl *tipPercentageSelector;
@property (nonatomic, retain) UITextField *customTipPercentageTextField;
@property (nonatomic, retain) UITextField *numberOfPeopleTextField;

// Arrays
@property (nonatomic, retain) NSArray<NSNumber *> *tipPercentages;

// Index Property and Custom Tip Boolean
@property (nonatomic, assign) NSInteger selectedTipIndex;
@property (nonatomic, assign) BOOL isCustomTipEnabled;
@property (nonatomic, assign) BOOL clearButtonHasBeenTapped;

@end

@implementation ViewController


#pragma mark - UI Setup Methods

/// Sets up the view background, navigation title, and bar buttons
- (void) setupNavigationController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = NSLocalizedString(@"Tip Calculator", "Title");
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    [self setupNavigationBarButtons];
}

/// Sets up the buttons on the navigation bar.
- (void) setupNavigationBarButtons {
    UIBarButtonItem *clearScreenButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Clear", @"Clear Button") style: UIBarButtonItemStylePlain target: self action: @selector(clearScreenTapped)];
    self.clearScreenButton = clearScreenButtonItem;
    [clearScreenButtonItem release];
    self.navigationItem.rightBarButtonItem = self.clearScreenButton;
    
    // Sets the UI button tint if the iOS version is below iOS 26.0
    if (@available(iOS 26.0, *)) {
        // No tint color since navigation bar buttons don't require tint
    } else {
        self.clearScreenButton.tintColor = [UIColor colorNamed: @"AccentColor"];
    }
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

/// Clears inputs and resets calculated labels
- (void) clearScreenTapped {
    
    self.clearButtonHasBeenTapped = YES;
    
    // Clear text fields
    self.checkAmountTextField.text = @"";
    self.customTipPercentageTextField.text = @"";
    self.numberOfPeopleTextField.text = @"";

    // Reset calculator values
    self.selectedTipIndex = 0;
    self.tipPercentageSelector.selectedSegmentIndex = 0;
    self.tipCalculator.checkAmount = 0.0;
    self.tipCalculator.tipPercentage = 0.0;
    self.tipCalculator.numberOfPeopleOnCheck = 0.0;
    
    [self inputChanged];
    
    // Clear the tip and check labels
    self.tipAmountLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    
    // Reset flag
    self.clearButtonHasBeenTapped = NO;
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
    [super dealloc];
}

@end
