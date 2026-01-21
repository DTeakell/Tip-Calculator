//
//  ColorCell.m
//  Tip
//
//  Created by Dillon Teakell on 11/12/25.
//

#import "AppIconColorCell.h"
#import "SettingsManager.h"

@implementation AppIconColorCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}


- (void) setupView {
    
    // App Icon Image
    UIImageView *appIconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(12.5, 17, 22.5, 22.5)];
    
    // Make configuration
    UIImageSymbolConfiguration *multicolorConfiguration = [UIImageSymbolConfiguration configurationPreferringMulticolor];
    UIImageSymbolConfiguration *sizeConfiguration = [UIImageSymbolConfiguration configurationWithScale: UIImageSymbolScaleSmall];
    UIImageSymbolConfiguration *appIconConfiguration = [multicolorConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    
    appIconImageView.preferredSymbolConfiguration = appIconConfiguration;
    appIconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.appIconImage = appIconImageView;
    [appIconImageView release];
    
    // Theme Color Label
    self.colorLabel = [[[UILabel alloc] init] autorelease];
    self.colorLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.colorLabel.numberOfLines = 0;
    self.colorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorLabel.adjustsFontForContentSizeCategory = YES;
    
    
    // Checkmark
    UIImageView *checkmark = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"checkmark"]];
    UIImageSymbolConfiguration *monochromeConfiguration = [UIImageSymbolConfiguration configurationPreferringMonochrome];
    UIImageSymbolConfiguration *checkmarkConfiguration = [monochromeConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    
    checkmark.preferredSymbolConfiguration = checkmarkConfiguration;
    checkmark.translatesAutoresizingMaskIntoConstraints = NO;
    self.checkmark = checkmark;
    [checkmark release];
    
    [self.contentView addSubview: self.appIconImage];
    [self.contentView addSubview: self.colorLabel];
    [self.contentView addSubview: self.checkmark];
}

- (void) setConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        
        // App Icon Image
        [self.appIconImage.firstBaselineAnchor constraintEqualToAnchor: self.contentView.firstBaselineAnchor constant: 5.0],
        [self.appIconImage.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        
        // Label
        [self.colorLabel.leadingAnchor constraintEqualToAnchor:self.appIconImage.trailingAnchor constant: 10],
        [self.colorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.colorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.colorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],

        // Checkmark
        [self.checkmark.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.checkmark.centerYAnchor constraintEqualToAnchor: self.contentView.centerYAnchor]

    ]];
}

- (void) dealloc {
    [_checkmark release];
    [_appIconImage release];
    [_colorLabel release];
    [super dealloc];
}

@end
