//
//  ViewController.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextField *checkAmountTextField;
@property (nonatomic, retain) UISlider *tipPercentageSlider;
@property (nonatomic, retain) UILabel *checkTotalLabel;

@end

@implementation ViewController

- (void) loadView {
    UIView *view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = view;
    [view release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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



@end
