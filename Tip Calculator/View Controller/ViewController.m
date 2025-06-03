//
//  ViewController.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import "ViewController.h"
#import "TipCalculator.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) TipCalculator *tipCalculator;


@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextField *checkAmountTextField;
@property (nonatomic, retain) UILabel *tipAmountLabel;
@property (nonatomic, retain) UILabel *checkTotalLabel;
@property (nonatomic, retain) UISegmentedControl *tipPercentageControl;
@property (nonatomic, retain) UITextField *customTipPercentageTextField;
@property (nonatomic, retain) NSArray<NSNumber *> *tipPercentages;


@property (nonatomic, assign) NSInteger selectedTipIndex;
@property (nonatomic, assign) BOOL isCustomTipEnabled;
@property (nonatomic, retain) UISelectionFeedbackGenerator *tipPercentageFeedbackGenerator;


@end

@implementation ViewController

#pragma mark - Lifecycle Methods

- (void) loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the Tip Calculator class
    TipCalculator *calculator = [[TipCalculator alloc] init];
    self.tipCalculator = calculator;
    [calculator release];
    
    
    // Initialize Feedback Generator
    UISelectionFeedbackGenerator *feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    self.tipPercentageFeedbackGenerator = feedbackGenerator;
    [feedbackGenerator release];
    
    [self.tipPercentageFeedbackGenerator prepare];
    
    
    // Gesture to dismiss keyboard when screen is tapped
    UITapGestureRecognizer *tapOutsideOfKeyboardGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismissKeyboard)];
    [self.view addGestureRecognizer: tapOutsideOfKeyboardGesture];
    [tapOutsideOfKeyboardGesture release];
    
    
    NSArray *tipOptions = [[NSArray alloc] initWithObjects: @0, @10, @15, @20, @0, nil];
    self.tipPercentages = tipOptions;
    self.selectedTipIndex = 0;
    [tipOptions release];
    
    
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
    // Set up large navigation title
    self.title = @"Tip Calculator";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    
    
    // Set up table view
    self.tableView = [[[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleInsetGrouped] autorelease];
    
    // Assigns the current view controller as the table view delegate
    // This handles the behaviors and actions for the table view
    self.tableView.delegate = self;
    
    // Assigns the current view controller as the table view data source
    // This handles the data that goes into the table view (number of rows, what each row should look like, etc)
    self.tableView.dataSource = self;
    
    // This configures how the table is resized if the parent view controller is resized
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.tableView];
}



#pragma mark - Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}



#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1 && !self.isCustomTipEnabled) {
        return 0.0;
    }
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
        self.checkAmountTextField = [[[UITextField alloc] init] autorelease];
        self.checkAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.checkAmountTextField.placeholder = @"Enter Check Amount";
        self.checkAmountTextField.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
        self.checkAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.checkAmountTextField.tintColor = [UIColor systemOrangeColor];
        
        // Accessibility Labels
        self.checkAmountTextField.accessibilityLabel = @"Check amount input field";
        self.checkAmountTextField.accessibilityTraits = UIAccessibilityTraitKeyboardKey;
        
        
        [self.checkAmountTextField addTarget: self action: @selector(inputChanged) forControlEvents: UIControlEventEditingChanged];
        [cell.contentView addSubview: self.checkAmountTextField];
        
        // Constraints
        [NSLayoutConstraint activateConstraints: @[
            [self.checkAmountTextField.leadingAnchor constraintEqualToAnchor: cell.contentView.leadingAnchor constant: 20],
            [self.checkAmountTextField.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant: -20],
            [self.checkAmountTextField.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant: 15],
            [self.checkAmountTextField.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant: -15]
        ]];
    }
    
    #pragma mark - Segmented Control
    // Tip Percentage Segmented Control
    else if (indexPath.section == 1 && indexPath.row == 0) {
        self.tipPercentageControl = [[[UISegmentedControl alloc] initWithItems:@[@"0%", @"10%", @"15%", @"20%", @"Any"]] autorelease];
        self.tipPercentageControl.translatesAutoresizingMaskIntoConstraints = NO;
        self.tipPercentageControl.selectedSegmentIndex = self.selectedTipIndex;
        
        //Accessibility Labels
        self.tipPercentageControl.accessibilityLabel = @"Tip Percentage selector";
        self.tipPercentageControl.accessibilityTraits = UIAccessibilityTraitAdjustable;
        
        [self.tipPercentageControl addTarget: self action: @selector(segmentChanged:) forControlEvents: UIControlEventValueChanged];
        
        self.tipPercentageControl.selectedSegmentTintColor = [UIColor systemOrangeColor];
        
        [cell.contentView addSubview: self.tipPercentageControl];
        
        // Constraints
        [NSLayoutConstraint activateConstraints: @[
            [self.tipPercentageControl.leadingAnchor constraintEqualToAnchor: cell.contentView.leadingAnchor constant: 20],
            [self.tipPercentageControl.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant: -20],
            [self.tipPercentageControl.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant: 15],
            [self.tipPercentageControl.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant: -15]
        ]];
    }
    
    #pragma mark - Custom Tip Percentage Text Field
    // Custom Tip Percentage Text Field
    else if (indexPath.section == 1 && indexPath.row == 1) {
        self.customTipPercentageTextField = [[[UITextField alloc] init] autorelease];
        self.customTipPercentageTextField.translatesAutoresizingMaskIntoConstraints = NO;
        self.customTipPercentageTextField.placeholder = @"Custom Tip";
        self.customTipPercentageTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.customTipPercentageTextField.tintColor = [UIColor systemOrangeColor];
        
        [self.customTipPercentageTextField addTarget: self action: @selector(customTipChanged) forControlEvents: UIControlEventEditingChanged];
        
        [cell.contentView addSubview: self.customTipPercentageTextField];
        
        // Constraints
        [NSLayoutConstraint activateConstraints: @[
            [self.customTipPercentageTextField.leadingAnchor constraintEqualToAnchor: cell.contentView.leadingAnchor constant: 20],
            [self.customTipPercentageTextField.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant: -20],
            [self.customTipPercentageTextField.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant: 15],
            [self.customTipPercentageTextField.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant: -15]
        ]];
        
        // Hide if the tip isn't custom
        cell.contentView.hidden = !self.isCustomTipEnabled;
        
    }
    
    #pragma mark - Tip Amount Label
    // Tip Amount Label
    else if (indexPath.section == 2) {
        self.tipAmountLabel = [[[UILabel alloc] init] autorelease];
        self.tipAmountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.tipAmountLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
        self.tipAmountLabel.text = @"$0.00";
        [cell.contentView addSubview: self.tipAmountLabel];
        
        // Accessibility Labels
        self.tipAmountLabel.accessibilityLabel = @"Tip amount";
        self.tipAmountLabel.accessibilityValue = self.tipAmountLabel.text;
        
        
        // Constraints
        [NSLayoutConstraint activateConstraints: @[
            [self.tipAmountLabel.leadingAnchor constraintEqualToAnchor: cell.contentView.leadingAnchor constant: 20],
            [self.tipAmountLabel.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant: -20],
            [self.tipAmountLabel.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant: 15],
            [self.tipAmountLabel.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant: -15]
        ]];
        
    #pragma mark - Total Amount Label
    // Total Amount Label
    } else if (indexPath.section == 3) {
        
        // Changes 'body' font to have a semibold style and supports Dynamic Type
        UIFont *baseFont = [UIFont systemFontOfSize: UIFont.labelFontSize weight: UIFontWeightSemibold];
        UIFont *scaledFont = [[UIFontMetrics metricsForTextStyle: UIFontTextStyleBody] scaledFontForFont: baseFont];
        
        
        self.checkTotalLabel = [[[UILabel alloc] init] autorelease];
        self.checkTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;

        self.checkTotalLabel.font = scaledFont;
        self.checkTotalLabel.adjustsFontForContentSizeCategory = YES;
        self.checkTotalLabel.textColor = [UIColor systemOrangeColor];
        self.checkTotalLabel.text = @"$0.00";
        
        // Accessibility Label
        self.checkTotalLabel.accessibilityLabel = @"Total amount with tip";
        self.checkTotalLabel.accessibilityValue = self.checkTotalLabel.text;
        
        [cell.contentView addSubview: self.checkTotalLabel];
        
        // Constraints
        [NSLayoutConstraint activateConstraints: @[
            [self.checkTotalLabel.leadingAnchor constraintEqualToAnchor: cell.contentView.leadingAnchor constant: 20],
            [self.checkTotalLabel.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant: -20],
            [self.checkTotalLabel.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant: 15],
            [self.checkTotalLabel.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant: -15]
        ]];
    }
    
    return cell;
    
}

// Customize headers
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Check Amount";
    } else if (section == 1) {
        return @"Tip Percentage";
    } else if (section == 2) {
        return @"Tip Amount";
    } else if (section == 3) {
        return @"Check Total";
    }
    return nil;
}



#pragma mark - View Methods

// Dismiss keyboard
- (void) dismissKeyboard {
    [self.view endEditing: YES];
}


// Segment Control
- (void) segmentChanged: (UISegmentedControl *)sender {
    self.selectedTipIndex = sender.selectedSegmentIndex;
    
    // Trigger haptics on change
    [self.tipPercentageFeedbackGenerator selectionChanged];
    [self.tipPercentageFeedbackGenerator prepare];
    
    
    // Stores the current state of 'isCustomTipEnabled' before it gets updated
    BOOL wasCustom = self.isCustomTipEnabled;
    
    // Updates the flag when the selected tip is custom
    self.isCustomTipEnabled = (self.selectedTipIndex == self.tipPercentages.count - 1);
    
    // Switch from non-custom to custom
    if (!wasCustom && self.isCustomTipEnabled) {
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: 1 inSection: 1]]
                            withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    // Switch from custom to non-custom
    } else if (wasCustom && !self.isCustomTipEnabled) {
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: 1 inSection: 1]]
                            withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }

    // When the custom tip isn't enabled, carry out normal calculation
    if (!self.isCustomTipEnabled) {
        NSNumber *selectedTip = self.tipPercentages[self.selectedTipIndex];
        self.tipCalculator.tipPercentage = [selectedTip doubleValue];
        [self inputChanged];
    }
}


# pragma mark - Tip Calculation Methods

// Custom Tip Calculation Method
- (void) customTipChanged {
    double customTip = [self.customTipPercentageTextField.text doubleValue];
    self.tipCalculator.tipPercentage = customTip;
    [self inputChanged];
}


// Check Amount Input
- (void) inputChanged {
    double check = [self.checkAmountTextField.text doubleValue];
    
    self.tipCalculator.checkAmount = check;
    
    double tip = [self.tipCalculator calculateTip];
    double total = [self.tipCalculator calculateTotal];
    
    self.tipAmountLabel.text = [NSString stringWithFormat: @"$%.2f", tip];
    self.tipAmountLabel.accessibilityValue = [NSString stringWithFormat: @"$%.2f", tip];
    
    self.checkTotalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
    self.checkTotalLabel.accessibilityValue = [NSString stringWithFormat: @"$%.2f", total];
}



#pragma mark - Dealloc

- (void)dealloc {
    [_tableView release];
    [_checkAmountTextField release];
    [_tipPercentageControl release];
    [_tipPercentages release];
    [_customTipPercentageTextField release];
    [_tipPercentageFeedbackGenerator release];
    [_tipAmountLabel release];
    [_checkTotalLabel release];
    [_tipCalculator release];
    [super dealloc];
}

@end
