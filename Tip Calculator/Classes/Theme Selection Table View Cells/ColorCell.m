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
    
    // Circle Image
    UIImageView *circle = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"circle.fill"]];
    
    // Make config for the circle image
    UIImageSymbolConfiguration *multicolorConfiguration = [UIImageSymbolConfiguration configurationPreferringMulticolor];
    UIImageSymbolConfiguration *sizeConfiguration = [UIImageSymbolConfiguration configurationWithScale: UIImageSymbolScaleSmall];
    UIImageSymbolConfiguration *colorCircleConfiguration = [multicolorConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    circle.preferredSymbolConfiguration = colorCircleConfiguration;
    
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorCircle = circle;
    [circle release];
    
    // Theme Color Label
    self.colorLabel = [[[UILabel alloc] init] autorelease];
    self.colorLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.colorLabel.numberOfLines = 0;
    self.colorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorLabel.adjustsFontForContentSizeCategory = YES;
    
    
    // TODO: Checkmark
    UIImageView *checkmark = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"checkmark"]];
    UIImageSymbolConfiguration *monochromeConfiguration = [UIImageSymbolConfiguration configurationPreferringMonochrome];
    UIImageSymbolConfiguration *checkmarkConfiguration = [monochromeConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    
    checkmark.preferredSymbolConfiguration = checkmarkConfiguration;
    checkmark.translatesAutoresizingMaskIntoConstraints = NO;
    self.checkmark = checkmark;
    [checkmark release];
    
    [self.contentView addSubview: self.colorCircle];
    [self.contentView addSubview: self.colorLabel];
    [self.contentView addSubview: self.checkmark];
}

- (void) setConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        // Label
        [self.colorLabel.leadingAnchor constraintEqualToAnchor:self.colorCircle.trailingAnchor constant: 7.5],
        [self.colorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.colorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.colorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
        
        [self.colorCircle.firstBaselineAnchor constraintEqualToAnchor: self.colorLabel.firstBaselineAnchor],
        [self.colorCircle.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        
        [self.checkmark.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.checkmark.centerYAnchor constraintEqualToAnchor: self.contentView.centerYAnchor]

    ]];
}

- (void) dealloc {
    [_checkmark release];
    [_colorCircle release];
    [_colorLabel release];
    [super dealloc];
}

@end
