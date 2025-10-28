//
//  AccentColorCell.m
//  Tip
//
//  Created by Dillon Teakell on 10/28/25.
//

#import "AccentColorCell.h"

@implementation AccentColorCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}

- (void) setupView {
    self.accentColorLabel = [[[UILabel alloc] init] autorelease];
    self.accentColorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.accentColorLabel.adjustsFontForContentSizeCategory = YES;
    self.accentColorLabel.text = NSLocalizedString(@"Accent Color", @"Accent Color Label");
    
    [self.contentView addSubview: self.accentColorLabel];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
       [self.accentColorLabel.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20],
       [self.accentColorLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20],
       [self.accentColorLabel.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 15],
       [self.accentColorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -15]
    ]];
}

- (void) dealloc {
    [_accentColorLabel release];
    [super dealloc];
}

@end
