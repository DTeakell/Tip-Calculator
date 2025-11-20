//
//  ColorCell.m
//  Tip
//
//  Created by Dillon Teakell on 11/12/25.
//

#import "ColorCell.h"
#import "SettingsManager.h"

@implementation ColorCell

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
    self.colorLabel = [[[UILabel alloc] init] autorelease];
    self.colorLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.colorLabel.numberOfLines = 0;
    self.colorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorLabel.adjustsFontForContentSizeCategory = YES;
    [self.contentView addSubview: self.colorLabel];

}

- (void) setConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        // Label
        [self.colorLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.colorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.colorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.colorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]

    ]];
}

- (void)dealloc {
    [_colorLabel release];
    [super dealloc];
}

@end
