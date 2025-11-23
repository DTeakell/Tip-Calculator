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
    //TODO: Color Circle Image
    UIImageView *circle = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"circle.fill"]];
    
    // Make config for the circle image
    UIImageSymbolConfiguration *colorConfiguration = [UIImageSymbolConfiguration configurationPreferringMulticolor];
    UIImageSymbolConfiguration *sizeConfiguration = [UIImageSymbolConfiguration configurationWithScale: UIImageSymbolScaleSmall];
    
    UIImageSymbolConfiguration *configuration = [colorConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    
    circle.preferredSymbolConfiguration = configuration;
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorCircle = circle;
    [circle release];
    
    //MARK: Theme Color Cell Label
    self.colorLabel = [[[UILabel alloc] init] autorelease];
    self.colorLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.colorLabel.numberOfLines = 0;
    self.colorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorLabel.adjustsFontForContentSizeCategory = YES;
    [self.contentView addSubview: self.colorCircle];
    [self.contentView addSubview: self.colorLabel];
}

- (void) setConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        // Label
        [self.colorLabel.leadingAnchor constraintEqualToAnchor:self.colorCircle.trailingAnchor constant: 7.5],
        [self.colorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.colorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.colorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
        
        [self.colorCircle.firstBaselineAnchor constraintEqualToAnchor: self.colorLabel.firstBaselineAnchor],
        [self.colorCircle.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor]

    ]];
}

- (void) dealloc {
    [_colorCircle release];
    [_colorLabel release];
    [super dealloc];
}

@end
