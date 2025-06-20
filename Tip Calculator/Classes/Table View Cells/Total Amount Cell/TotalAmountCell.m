//
//  TotalAmountCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "TotalAmountCell.h"
#import <UIKit/UIKit.h>

@implementation TotalAmountCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}


- (UIFont *) setCustomFont {
    UIFont *baseFont = [UIFont systemFontOfSize: UIFont.labelFontSize weight: UIFontWeightSemibold];
    UIFont *scaledFont = [[UIFontMetrics metricsForTextStyle: UIFontTextStyleBody] scaledFontForFont: baseFont];
    return scaledFont;
}

- (void) setupView {
    self.checkTotalLabel = [[[UILabel alloc] init] autorelease];
    self.checkTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.checkTotalLabel.font = [self setCustomFont];
    self.checkTotalLabel.adjustsFontForContentSizeCategory = YES;
    self.checkTotalLabel.textColor = [UIColor systemOrangeColor];
    self.checkTotalLabel.text = @"$0.00";
    
    // Accessibility Label
    self.checkTotalLabel.accessibilityLabel = @"Total amount with tip";
    self.checkTotalLabel.accessibilityValue = self.checkTotalLabel.text;
    
    [self.contentView addSubview: self.checkTotalLabel];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.checkTotalLabel.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20],
        [self.checkTotalLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20],
        [self.checkTotalLabel.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 15],
        [self.checkTotalLabel.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -15]
    ]];
}

- (void) dealloc {
    [_checkTotalLabel release];
    [super dealloc];
}

@end
