//
//  SaveTipPercentageCell.m
//  Tip
//
//  Created by Dillon Teakell on 11/5/25.
//

#import "SaveTipPercentageCell.h"

@implementation SaveTipPercentageCell

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
    self.savePercentageLabel = [[[UILabel alloc] init] autorelease];
    self.savePercentageLabel.text = @"Save Tip Percentage";
    self.savePercentageLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.savePercentageLabel.numberOfLines = 0;
    self.savePercentageLabel.adjustsFontForContentSizeCategory = YES;
    self.savePercentageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview: self.savePercentageLabel];
    
    // Switch
    self.saveTipPercentageSwitch = [[[UISwitch alloc] init] autorelease];
    self.saveTipPercentageSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: self.saveTipPercentageSwitch];
}

- (void) setConstraints {
    
    // Label Constraints
    [NSLayoutConstraint activateConstraints: @[
       [self.savePercentageLabel.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
       [self.savePercentageLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
       [self.savePercentageLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
       
       // Switch Constraints
       [self.saveTipPercentageSwitch.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
       [self.saveTipPercentageSwitch.centerYAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.centerYAnchor],
       
       // Spacing
       [self.savePercentageLabel.trailingAnchor constraintLessThanOrEqualToAnchor: self.saveTipPercentageSwitch.leadingAnchor constant: -20]
    ]];
}

- (void) dealloc {
    [_savePercentageLabel release];
    [_saveTipPercentageSwitch release];
    [super dealloc];
}


@end
