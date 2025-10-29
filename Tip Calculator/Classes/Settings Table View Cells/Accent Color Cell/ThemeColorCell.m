//
//  AccentColorCell.m
//  Tip
//
//  Created by Dillon Teakell on 10/28/25.
//

#import "ThemeColorCell.h"

@implementation ThemeColorCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupLabelView];
        [self setConstraints];
    }
    
    return self;
}

- (void) setupLabelView {
    self.themeColorLabel = [[[UILabel alloc] init] autorelease];
    self.themeColorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.themeColorLabel.adjustsFontForContentSizeCategory = YES;
    self.themeColorLabel.text = NSLocalizedString(@"Accent Color", @"Accent Color Label");
    
    [self.contentView addSubview: self.themeColorLabel];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
       [self.themeColorLabel.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20],
       [self.themeColorLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20],
       [self.themeColorLabel.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 15],
       [self.themeColorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -15]
    ]];
}

- (void) dealloc {
    [_themeColorLabel release];
    [super dealloc];
}

@end
