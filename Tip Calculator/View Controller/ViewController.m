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
@property (nonatomic, retain) UISlider *tipPercentageSlider;
@property (nonatomic, retain) UILabel *checkTotalLabel;


@end

@implementation ViewController

#pragma mark - Lifecycle

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



#pragma mark - Table View Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}



#pragma mark - Table View Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    
    // Set up TableView cells
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID] autorelease];
    } else {
        while ([cell.contentView.subviews count] > 0) {
            [[[cell.contentView subviews] lastObject] removeFromSuperview];
        }
    }
    
    // Create text field
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.checkAmountTextField = [[[UITextField alloc] init] autorelease];
        self.checkAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.checkAmountTextField.placeholder = @"Enter Check Amount";
        self.checkAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.checkAmountTextField.tintColor = [UIColor systemPinkColor];
        
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
    
    // Create slider
    else if (indexPath.section == 0 && indexPath.row == 1) {
        self.tipPercentageSlider = [[[UISlider alloc] init] autorelease];
        self.tipPercentageSlider.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.tipPercentageSlider.minimumValue = 0;
        self.tipPercentageSlider.maximumValue = 100;
        self.tipPercentageSlider.value = 20;
        self.tipPercentageSlider.tintColor = [UIColor systemPinkColor];
        
        self.tipPercentageSlider.translatesAutoresizingMaskIntoConstraints = NO;
        [self.tipPercentageSlider addTarget: self action:@selector(inputChanged) forControlEvents: UIControlEventValueChanged];
        [cell.contentView addSubview: self.tipPercentageSlider];
        
        // Constraints
        [NSLayoutConstraint activateConstraints: @[
            [self.tipPercentageSlider.leadingAnchor constraintEqualToAnchor: cell.contentView.leadingAnchor constant: 20],
            [self.tipPercentageSlider.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant: -20],
            [self.tipPercentageSlider.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant: 10],
            [self.tipPercentageSlider.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant: -10]
        ]];
        
        
        
    // Create label
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        self.checkTotalLabel = [[[UILabel alloc] init] autorelease];
        self.checkTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;

        self.checkTotalLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
        self.checkTotalLabel.text = @"Total: $0.00";
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

- (void) inputChanged {
    double check = [self.checkAmountTextField.text doubleValue];
    double tipPercentage = self.tipPercentageSlider.value;
    
    self.tipCalculator.checkAmount = check;
    self.tipCalculator.tipPercentage = tipPercentage;
    
    //double tip = [self.tipCalculator calculateTip];
    double total = [self.tipCalculator calculateTotal];
    
    self.checkTotalLabel.text = [NSString stringWithFormat:@"Total: $%.2f", total];
}

- (void) dealloc {
    [_tableView release];
    [_checkAmountTextField release];
    [_tipPercentageSlider release];
    [_checkTotalLabel release];
    [_tipCalculator release];
    [super dealloc];
}




@end
