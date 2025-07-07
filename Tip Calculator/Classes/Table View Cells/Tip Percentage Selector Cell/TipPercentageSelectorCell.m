//
//  TipPercentageSelectorCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "TipPercentageSelectorCell.h"

@implementation TipPercentageSelectorCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}

- (void) setupView {
    self.tipPercentageSelector = [[[UISegmentedControl alloc] initWithItems:@[@"0%", @"10%", @"15%", @"20%", @"Any"]] autorelease];
    self.tipPercentageSelector.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Accessibility Labels
    self.tipPercentageSelector.accessibilityLabel = @"Tip Percentage selector";
    self.tipPercentageSelector.accessibilityTraits = UIAccessibilityTraitAdjustable;
    
    self.tipPercentageSelector.selectedSegmentTintColor = [UIColor colorNamed: @"AccentColor"];
    
    [self.contentView addSubview: self.tipPercentageSelector];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.tipPercentageSelector.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20],
        [self.tipPercentageSelector.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20],
        [self.tipPercentageSelector.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 15],
        [self.tipPercentageSelector.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -15]
    ]];
}

- (void) dealloc {
    [_tipPercentageSelector release];
    [super dealloc];
}

@end
