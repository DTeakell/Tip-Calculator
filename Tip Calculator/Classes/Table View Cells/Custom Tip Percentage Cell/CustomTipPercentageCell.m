//
//  CustomTipPercentageCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "CustomTipPercentageCell.h"

@implementation CustomTipPercentageCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    return self;
}


- (void) setupView {
    self.customTipPercentageTextField = [[[UITextField alloc] init] autorelease];
    self.customTipPercentageTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.customTipPercentageTextField.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.customTipPercentageTextField.placeholder = @"Enter Custom Tip Percentage";
    self.customTipPercentageTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.customTipPercentageTextField.tintColor = [UIColor systemOrangeColor];
    
    self.customTipPercentageTextField.accessibilityLabel = @"Check amount input field";
    self.customTipPercentageTextField.accessibilityTraits = UIAccessibilityTraitKeyboardKey;
    
    [self.contentView addSubview: self.customTipPercentageTextField];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.customTipPercentageTextField.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20],
        [self.customTipPercentageTextField.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20],
        [self.customTipPercentageTextField.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 15],
        [self.customTipPercentageTextField.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -15]
    ]];
}

- (void) dealloc {
    [_customTipPercentageTextField release];
    [super dealloc];
}

@end
