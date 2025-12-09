//
//  ShowRoundedTotalsCell.m
//  Tip
//
//  Created by Dillon Teakell on 11/5/25.
//

#import "ShowRoundedTotalsCell.h"

@implementation ShowRoundedTotalsCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}

- (void) setupView {
    // Label
    self.showRoundedTotalsLabel = [[[UILabel alloc] init] autorelease];
    self.showRoundedTotalsLabel.text = @"Show Rounded Total";
    self.showRoundedTotalsLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.showRoundedTotalsLabel.adjustsFontForContentSizeCategory = YES;
    self.showRoundedTotalsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.showRoundedTotalsLabel.numberOfLines = 0;
    
    [self.contentView addSubview: self.showRoundedTotalsLabel];
    
    // Switch
    self.showRoundedTotalsSwitch = [[[UISwitch alloc] init] autorelease];
    self.showRoundedTotalsSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview: self.showRoundedTotalsSwitch];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        // Label
        [self.showRoundedTotalsLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.showRoundedTotalsLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.showRoundedTotalsLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],

        // Switch
        [self.showRoundedTotalsSwitch.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.showRoundedTotalsSwitch.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],

        // Space between label and switch
        [self.showRoundedTotalsLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.showRoundedTotalsSwitch.leadingAnchor constant: -10],
    ]];
}

- (void) dealloc {
    [_showRoundedTotalsLabel release];
    [_showRoundedTotalsSwitch release];
    [super dealloc];
}

@end

