//
//  ThemeColorCell.m
//  Tip
//
//  Created by Dillon Teakell on 10/28/25.
//

#import "ThemeColorCell.h"
#import "SettingsManager.h"

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

    
    // Selected Theme Label
    self.selectedColorLabel = [[[UILabel alloc] init] autorelease];
    
    self.selectedColorLabel.text = [[SettingsManager sharedManager] nameForTheme: [SettingsManager sharedManager].currentTheme];
    self.selectedColorLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.selectedColorLabel.textColor = [UIColor systemGrayColor];
    self.selectedColorLabel.numberOfLines = 0;
    self.selectedColorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.selectedColorLabel.adjustsFontForContentSizeCategory = YES;
    [self.contentView addSubview: self.selectedColorLabel];
    
}

- (void) setConstraints {
    
    // Get the current size catagory of the text
    UIContentSizeCategory catagory = self.traitCollection.preferredContentSizeCategory;
    
    // Put the label on the trailing edge of the cell if the Dynamic Text size is less than large
    if (catagory < UIContentSizeCategoryAccessibilityLarge) {
        [NSLayoutConstraint activateConstraints:@[
            // Cell Title Label
            [self.themeColorLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
            [self.themeColorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
            [self.themeColorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
            [self.themeColorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
            
            // Selected Theme Color Label
            [self.selectedColorLabel.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
            [self.selectedColorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
            [self.selectedColorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
        ]];
    
    // Put the label below the title in sizes greater than large
    } else {
        [NSLayoutConstraint activateConstraints:@[
            // Cell Title Label
            [self.themeColorLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
            [self.themeColorLabel.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
            [self.themeColorLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
            
            // Selected Theme Color Label
            [self.selectedColorLabel.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
            [self.selectedColorLabel.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
            [self.selectedColorLabel.topAnchor constraintEqualToAnchor: self.themeColorLabel.bottomAnchor],
            [self.selectedColorLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor],
        ]];
    }
}

- (void) dealloc {
    [_themeColorLabel release];
    [_selectedColorLabel release];
    [super dealloc];
}

@end
