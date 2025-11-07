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
    
    // Set text alignment for placeholder and text
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute: self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
        self.customTipPercentageTextField.textAlignment = NSTextAlignmentRight;
        self.customTipPercentageTextField.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    } else {
        self.customTipPercentageTextField.textAlignment = NSTextAlignmentLeft;
        self.customTipPercentageTextField.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    }
    
    self.customTipPercentageTextField.placeholder = NSLocalizedString(@"Enter Custom Tip Percentage", @"Custom tip percentage text field");
    self.customTipPercentageTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.customTipPercentageTextField.tintColor = [UIColor colorNamed: @"AccentColor"];
    
    self.customTipPercentageTextField.accessibilityLabel = @"Custom tip percentage field";
    self.customTipPercentageTextField.accessibilityTraits = UIAccessibilityTraitKeyboardKey;
    
    [self.contentView addSubview: self.customTipPercentageTextField];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.customTipPercentageTextField.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.customTipPercentageTextField.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.customTipPercentageTextField.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.customTipPercentageTextField.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void) dealloc {
    [_customTipPercentageTextField release];
    [super dealloc];
}

@end
