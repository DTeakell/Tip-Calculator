//
//  ThemeColorCell.m
//  Tip
//
//  Created by Dillon Teakell on 10/28/25.
//

#import "ThemeColorCell.h"

@implementation ThemeColorCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}

- (void) setupView {
    //MARK: Theme Color Cell Label
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.themeColorLabel = [[[UILabel alloc] init] autorelease];
    self.themeColorLabel.text = NSLocalizedString(@"Theme Color", @"Theme Color Title");
    self.themeColorLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.themeColorLabel.numberOfLines = 0;
    self.themeColorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.themeColorLabel.adjustsFontForContentSizeCategory = YES;
    [self.contentView addSubview: self.themeColorLabel];

}

- (void) setConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        // Label
        [self.themeColorLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.themeColorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.themeColorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.themeColorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]

    ]];
}

- (void) dealloc {
    [_themeColorLabel release];
    [super dealloc];
}

@end
