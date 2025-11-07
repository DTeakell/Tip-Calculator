//
//  AppIconCell.m
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import "AppIconCell.h"

@implementation AppIconCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}

- (void) setupView {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.appIconLabel = [[[UILabel alloc] init] autorelease];
    self.appIconLabel.text = @"App Icon";
    self.appIconLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.appIconLabel.numberOfLines = 0;
    self.appIconLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.appIconLabel.adjustsFontForContentSizeCategory = YES;
    
    [self.contentView addSubview: self.appIconLabel];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // Label
        [self.appIconLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.appIconLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.appIconLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.appIconLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]

    ]];
}

- (void) dealloc {
    [_appIconLabel release];
    [super dealloc];
}

@end
