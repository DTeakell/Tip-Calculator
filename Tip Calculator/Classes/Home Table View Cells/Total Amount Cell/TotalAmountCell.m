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

- (void)applyTheme {
    ThemeColorType theme = [SettingsManager sharedManager].currentTheme;
    UIColor *color = [[SettingsManager sharedManager] colorForTheme:theme];

    self.checkTotalLabel.textColor = color;
}


- (UIFont *) setCustomFont {
    UIFont *baseFont = [UIFont systemFontOfSize: UIFont.labelFontSize weight: UIFontWeightSemibold];
    UIFont *scaledFont = [[UIFontMetrics metricsForTextStyle: UIFontTextStyleBody] scaledFontForFont: baseFont];
    return scaledFont;
}

- (void) setupView {
    
    // Total Label
    self.checkTotalLabel = [[[UILabel alloc] init] autorelease];
    self.checkTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.checkTotalLabel.font = [self setCustomFont];
    self.checkTotalLabel.adjustsFontForContentSizeCategory = YES;
    self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    
    // Rounded Total Label
    self.roundedTotalLabel = [[[UILabel alloc] init] autorelease];
    self.roundedTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.roundedTotalLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleCaption1];
    self.roundedTotalLabel.adjustsFontForContentSizeCategory = YES;
    self.roundedTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.roundedTotalLabel.textColor = [UIColor systemGrayColor];
    
    // Arrow Image
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"arrow.up"]];
    UIImageSymbolConfiguration *colorConfiguration = [UIImageSymbolConfiguration configurationPreferringMonochrome];
    UIImageSymbolConfiguration *sizeConfiguration = [UIImageSymbolConfiguration configurationWithScale: UIImageSymbolScaleSmall];
    UIImageSymbolConfiguration *arrowConfiguration = [colorConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    
    arrowImageView.preferredSymbolConfiguration = arrowConfiguration;
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    arrowImageView.tintColor = [UIColor systemGrayColor];
    self.upArrowImageView = arrowImageView;
    [arrowImageView release];
    
    // Inner stack for rounded total + arrow (tighter grouping)
    UIStackView *roundedGroupStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.roundedTotalLabel, self.upArrowImageView]];
    roundedGroupStack.axis = UILayoutConstraintAxisHorizontal;
    roundedGroupStack.alignment = UIStackViewAlignmentCenter;
    roundedGroupStack.spacing = 2.0;
    roundedGroupStack.translatesAutoresizingMaskIntoConstraints = NO;

    // Ensure the arrow hugs the rounded total
    [self.upArrowImageView setContentHuggingPriority: UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.upArrowImageView setContentCompressionResistancePriority: UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    // Outer stack for total + (rounded total + arrow)
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.checkTotalLabel, roundedGroupStack]];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 20.0;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;

    self.totalStackView = stackView;
    [roundedGroupStack release];
    [stackView release];

    [self.contentView addSubview:self.totalStackView];
}

- (void) setConstraints {
    [self.checkTotalLabel setContentHuggingPriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [self.checkTotalLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [self.roundedTotalLabel setContentHuggingPriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
    [self.roundedTotalLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.totalStackView.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.totalStackView.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
        [self.totalStackView.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.totalStackView.trailingAnchor constraintLessThanOrEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor]
    ]];
}

- (void) dealloc {
    [_checkTotalLabel release];
    [super dealloc];
}

@end

