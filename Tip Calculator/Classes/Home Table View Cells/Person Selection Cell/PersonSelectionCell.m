//
//  PersonSelectionCell.m
//  Tip
//
//  Created by Dillon Teakell on 7/3/25.
//

#import "PersonSelectionCell.h"

@implementation PersonSelectionCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}


- (void) setupView {
    self.numberOfPeopleTextField = [[[UITextField alloc] init] autorelease];
    self.numberOfPeopleTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set text alignment for placeholder and text
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute: self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
        self.numberOfPeopleTextField.textAlignment = NSTextAlignmentRight;
        self.numberOfPeopleTextField.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    } else {
        self.numberOfPeopleTextField.textAlignment = NSTextAlignmentLeft;
        self.numberOfPeopleTextField.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    }
    
    self.numberOfPeopleTextField.placeholder = NSLocalizedString(@"Enter Number of People", @"Number of People Text Field");
    self.numberOfPeopleTextField.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.numberOfPeopleTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    // Accessibility Labels
    self.numberOfPeopleTextField.accessibilityLabel = NSLocalizedString(@"Number of People Text Field",@"Number of People Text Field");
    self.numberOfPeopleTextField.accessibilityTraits = UIAccessibilityTraitKeyboardKey;
    
    [self.contentView addSubview: self.numberOfPeopleTextField];
    
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.numberOfPeopleTextField.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.numberOfPeopleTextField.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.numberOfPeopleTextField.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.numberOfPeopleTextField.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void) dealloc {
    [_numberOfPeopleTextField release];
    [super dealloc];
}

@end
