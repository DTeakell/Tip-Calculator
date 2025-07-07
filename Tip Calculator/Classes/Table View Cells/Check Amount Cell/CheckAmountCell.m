//
//  CheckAmountCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "CheckAmountCell.h"

@implementation CheckAmountCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    return self;
}

- (void) setupView {
    self.checkAmountTextField = [[[UITextField alloc] init] autorelease];
    self.checkAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.checkAmountTextField.placeholder = NSLocalizedString(@"Enter Check Amount", @"Check Amount Text Field Placeholder");
    self.checkAmountTextField.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.checkAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.checkAmountTextField.tintColor = [UIColor colorNamed: @"AccentColor"];
    
    // Accessibility Labels
    self.checkAmountTextField.accessibilityLabel = @"Check amount input field";
    self.checkAmountTextField.accessibilityTraits = UIAccessibilityTraitKeyboardKey;
    
    [self.contentView addSubview: self.checkAmountTextField];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.checkAmountTextField.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20],
        [self.checkAmountTextField.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20],
        [self.checkAmountTextField.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 15],
        [self.checkAmountTextField.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -15]
    ]];
}

- (void) dealloc {
    [_checkAmountTextField release];
    [super dealloc];
}

@end
