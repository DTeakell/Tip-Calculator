//
//  TipPercentageSelectorCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "TipPercentageSelectorCell.h"
#import "SettingsManager.h"

@implementation TipPercentageSelectorCell

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

    self.tipPercentageSelector.selectedSegmentTintColor = color;
}

- (void) setupView {
    
    self.tipPercentageSelector = [[[UISegmentedControl alloc] initWithItems:@[@"0%", @"10%", @"15%", @"20%",
                                                                              NSLocalizedString(@"Any", @"Custom Tip Percentage")]] autorelease];
    self.tipPercentageSelector.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Accessibility Labels
    self.tipPercentageSelector.accessibilityLabel = @"Tip Percentage selector";
    self.tipPercentageSelector.accessibilityTraits = UIAccessibilityTraitAdjustable;
    
    [self.contentView addSubview: self.tipPercentageSelector];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.tipPercentageSelector.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.tipPercentageSelector.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.tipPercentageSelector.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.tipPercentageSelector.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void) dealloc {
    [_tipPercentageSelector release];
    [super dealloc];
}

@end
