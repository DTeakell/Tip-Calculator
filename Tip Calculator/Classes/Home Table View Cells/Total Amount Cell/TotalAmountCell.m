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
    
    // Check Total Label
    self.checkTotalLabel = [[[UILabel alloc] init] autorelease];
    self.checkTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.checkTotalLabel.font = [self setCustomFont];
    self.checkTotalLabel.adjustsFontForContentSizeCategory = YES;
    self.checkTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.checkTotalLabel.numberOfLines = 0;
    
    // Rounded Total Label
    self.roundedTotalLabel = [[[UILabel alloc] init] autorelease];
    self.roundedTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.roundedTotalLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleCaption1];
    self.roundedTotalLabel.adjustsFontForContentSizeCategory = YES;
    self.roundedTotalLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.roundedTotalLabel.numberOfLines = 0;
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
    roundedGroupStack.alignment = UIStackViewAlignmentLeading;
    roundedGroupStack.spacing = 2.0;
    roundedGroupStack.translatesAutoresizingMaskIntoConstraints = NO;
    self.roundedStackView = roundedGroupStack;
    [roundedGroupStack release];

    // Ensure the arrow hugs the rounded total
    [self.upArrowImageView setContentHuggingPriority: UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.upArrowImageView setContentCompressionResistancePriority: UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    // Outer stack for total + (rounded total + arrow)
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.checkTotalLabel, self.roundedStackView]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 2.5;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;

    self.totalStackView = stackView;
    [stackView release];

    [self.contentView addSubview:self.totalStackView];
}

- (void) setConstraints {
    [self.roundedTotalLabel setContentHuggingPriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [self.roundedTotalLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.totalStackView.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.totalStackView.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.totalStackView.topAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.topAnchor],
        [self.totalStackView.bottomAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void)configureWithRoundedTotalActive: (BOOL) active {
    if (!active) {
        self.roundedStackView.hidden = YES;
    } else {
        self.roundedStackView.hidden = NO;
    }
}


- (void) dealloc {
    [_checkTotalLabel release];
    [super dealloc];
}

@end
