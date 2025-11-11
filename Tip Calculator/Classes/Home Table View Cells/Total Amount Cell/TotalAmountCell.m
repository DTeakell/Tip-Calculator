//
//  TotalAmountCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "TotalAmountCell.h"
#import "CurrencyFormatter.h"
#import "SettingsManager.h"

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
    UIColor *accentColor = [[SettingsManager sharedManager] colorForTheme: [SettingsManager sharedManager].currentTheme];
    
    self.checkTotalLabel = [[[UILabel alloc] init] autorelease];
    self.checkTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.checkTotalLabel.font = [self setCustomFont];
    self.checkTotalLabel.adjustsFontForContentSizeCategory = YES;
    self.checkTotalLabel.textColor = accentColor;
    self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    
    [self.contentView addSubview: self.checkTotalLabel];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.checkTotalLabel.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.checkTotalLabel.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.checkTotalLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.checkTotalLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void) dealloc {
    [_checkTotalLabel release];
    [super dealloc];
}

@end
