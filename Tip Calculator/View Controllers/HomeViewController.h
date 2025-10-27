//
//  ViewController.h
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import <UIKit/UIKit.h>
#import "TipCalculator.h"

@interface HomeViewController : UIViewController

// Utilities
@property (nonatomic, retain) TipCalculator *tipCalculator;
@property (nonatomic, retain) UISelectionFeedbackGenerator *tipPercentageFeedbackGenerator;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;

// UI Properties
@property (nonatomic, strong) UIViewController *settingsViewController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextField *checkAmountTextField;
@property (nonatomic, retain) UIBarButtonItem *clearScreenButton;
@property (nonatomic, retain) UIBarButtonItem *settingsButton;
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

