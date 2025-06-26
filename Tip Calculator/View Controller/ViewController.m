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
#import "TipAmountCell.h"
#import "TotalAmountCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) TipCalculator *tipCalculator;


@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextField *checkAmountTextField;
@property (nonatomic, retain) UILabel *tipAmountLabel;
@property (nonatomic, retain) UILabel *checkTotalLabel;
@property (nonatomic, retain) UISegmentedControl *tipPercentageSelector;
@property (nonatomic, retain) UITextField *customTipPercentageTextField;
@property (nonatomic, retain) NSArray<NSNumber *> *tipPercentages;


@property (nonatomic, assign) NSInteger selectedTipIndex;
@property (nonatomic, assign) BOOL isCustomTipEnabled;
@property (nonatomic, retain) UISelectionFeedbackGenerator *tipPercentageFeedbackGenerator;


@end

@implementation ViewController


#pragma mark - UI Setup Methods

- (void) setupNavigationController {
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = @"Tip Calculator";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
}

- (void) setupTableViewUI {
    self.tableView = [[[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleInsetGrouped] autorelease];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.tableView];
    
    [self.tableView registerClass: [CheckAmountCell class] forCellReuseIdentifier: @"CheckAmountCell"];
    [self.tableView registerClass: [TipPercentageSelectorCell class] forCellReuseIdentifier: @"TipPercentageSelectorCell"];
    [self.tableView registerClass: [CustomTipPercentageCell class] forCellReuseIdentifier: @"CustomTipPercentageCell"];
    [self.tableView registerClass: [TipAmountCell class] forCellReuseIdentifier: @"TipAmountCell"];
    [self.tableView registerClass: [TotalAmountCell class] forCellReuseIdentifier: @"TotalAmountCell"];
}

- (void) setupUI {
    [self setupTableViewUI];
    [self setupNavigationController];
}


#pragma mark - Utility Setup Methods

- (void) setupTipCalculator {
    // Initialize the Tip Calculator class
    TipCalculator *calculator = [[TipCalculator alloc] init];
    self.tipCalculator = calculator;
    [calculator release];
}

- (void) setupTipPercentages {
    // Setup the array for tip percentages
    NSArray *tipOptions = [[NSArray alloc] initWithObjects: @0, @10, @15, @20, @0, nil];
    self.tipPercentages = tipOptions;
    self.selectedTipIndex = 0;
    [tipOptions release];
}

- (void) setupHaptics {
    // Initialize Feedback Generator
    UISelectionFeedbackGenerator *feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    self.tipPercentageFeedbackGenerator = feedbackGenerator;
    [feedbackGenerator release];
    
    [self.tipPercentageFeedbackGenerator prepare];
}

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
    
    [self setupTipPercentages];
    
    [self setupHaptics];
    
    [self setupGestures];
    
    [self setupUI];
}



#pragma mark - Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isCustomTipEnabled ? 5 : 4;
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
    
    
    #pragma mark - Tip Amount Label
    // Tip Amount Label
    else if (indexPath.section == 2 || (indexPath.section == 3 && self.isCustomTipEnabled)) {
        TipAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TipAmountCell"];
        self.tipAmountLabel = cell.tipAmountLabel;
        return cell;
        
    #pragma mark - Total Amount Label
    // Total Amount Label
    } else if (indexPath.section == 3 || (self.isCustomTipEnabled && indexPath.section == 4)) {
        TotalAmountCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TotalAmountCell"];
        self.checkTotalLabel = cell.checkTotalLabel;
        return cell;
    }
    
    return cell;
    
}

// Customize headers
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Check Amount";
    } else if (section == 1) {
        return @"Tip Percentage";
    }else if (self.isCustomTipEnabled && section == 2) {
        return @"Custom Tip Percentage";
    } else if (section == 2 || (self.isCustomTipEnabled && section == 3)) {
        return @"Tip Amount";
    } else if (section == 3 || (self.isCustomTipEnabled && section == 4)) {
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
    
    // Instead of using a different row, make a completely new section to avoid clipping.
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
    [_tipPercentageSelector release];
    [_tipPercentages release];
    [_customTipPercentageTextField release];
    [_tipPercentageFeedbackGenerator release];
    [_tipAmountLabel release];
    [_checkTotalLabel release];
    [_tipCalculator release];
    [super dealloc];
}

@end
