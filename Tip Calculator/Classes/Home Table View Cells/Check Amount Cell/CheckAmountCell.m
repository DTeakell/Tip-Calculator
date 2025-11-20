//
//  CheckAmountCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "CheckAmountCell.h"
#import "SettingsManager.h"

@implementation CheckAmountCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    return self;
}

- (void)applyTheme {
    ThemeColorType theme = [SettingsManager sharedManager].currentTheme;
    UIColor *color = [[SettingsManager sharedManager] colorForTheme:theme];

    self.checkAmountTextField.tintColor = color;
}

- (void) setupView {
    self.checkAmountTextField = [[[UITextField alloc] init] autorelease];
    self.checkAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set text alignment for placeholder and text
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute: self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
        self.checkAmountTextField.textAlignment = NSTextAlignmentRight;
        self.checkAmountTextField.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    } else {
        self.checkAmountTextField.textAlignment = NSTextAlignmentLeft;
        self.checkAmountTextField.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    }
    
    self.checkAmountTextField.placeholder = NSLocalizedString(@"Enter Check Amount", @"Check Amount Text Field Placeholder");
    self.checkAmountTextField.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.checkAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Accessibility Labels
    self.checkAmountTextField.accessibilityLabel = @"Check amount input field";
    self.checkAmountTextField.accessibilityTraits = UIAccessibilityTraitKeyboardKey;
    
    [self.contentView addSubview: self.checkAmountTextField];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.checkAmountTextField.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.checkAmountTextField.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.checkAmountTextField.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.checkAmountTextField.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void) dealloc {
    [_checkAmountTextField release];
    [super dealloc];
}

@end
