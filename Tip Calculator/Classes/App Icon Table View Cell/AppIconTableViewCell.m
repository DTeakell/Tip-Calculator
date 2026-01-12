//
//  AppIconCell.m
//  Tip
//
//  Created by Dillon Teakell on 1/9/26.
//

#import "AppIconTableViewCell.h"

@implementation AppIconTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}

// TODO: Finish View Setup
- (void) setupView {
    
    // App Icon Image Configuration
    UIImageSymbolConfiguration *sizeConfiguration = [UIImageSymbolConfiguration configurationWithScale: UIImageSymbolScaleSmall];
    
    // App Icon Image View
    UIImageView *appIconImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"AppIcon-Red" inBundle: NSBundle.mainBundle  withConfiguration: sizeConfiguration]];
    
    appIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appIconImage = appIconImageView;
    [appIconImageView release];
    
    
    // App Icon Name Label
    self.appIconDisplayNameLabel = [[[UILabel alloc] init] autorelease];
    self.appIconDisplayNameLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.appIconDisplayNameLabel.text = @"App Icon Display Name";
    self.appIconDisplayNameLabel.numberOfLines = 0;
    self.appIconDisplayNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.appIconDisplayNameLabel.adjustsFontForContentSizeCategory = YES;
    
    
    // Checkmark
    UIImageView *checkmark = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"checkmark"]];
    UIImageSymbolConfiguration *monochromeConfiguration = [UIImageSymbolConfiguration configurationPreferringMonochrome];
    UIImageSymbolConfiguration *checkmarkConfiguration = [monochromeConfiguration configurationByApplyingConfiguration: sizeConfiguration];
    
    checkmark.preferredSymbolConfiguration = checkmarkConfiguration;
    checkmark.translatesAutoresizingMaskIntoConstraints = NO;
    self.checkmark = checkmark;
    [checkmark release];
    
    [self.contentView addSubview: self.appIconImage];
    [self.contentView addSubview: self.appIconDisplayNameLabel];
    [self.contentView addSubview: self.checkmark];
    
    
}

// TODO: Finish Constraints
- (void) setConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // Label
        [self.appIconDisplayNameLabel.leadingAnchor constraintEqualToAnchor:self.appIconImage.trailingAnchor],
        [self.appIconDisplayNameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.appIconDisplayNameLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.appIconDisplayNameLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
        
        // Color Circle Image
        [self.appIconImage.firstBaselineAnchor constraintEqualToAnchor: self.appIconDisplayNameLabel.firstBaselineAnchor constant: 10],
        [self.appIconImage.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        
        // Checkmark
        [self.checkmark.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.checkmark.centerYAnchor constraintEqualToAnchor: self.contentView.centerYAnchor]

    ]];
}

- (void)dealloc {
    [_checkmark release];
    [_appIconDisplayNameLabel release];
    [_appIconImage release];
    [super dealloc];
    
}


@end
