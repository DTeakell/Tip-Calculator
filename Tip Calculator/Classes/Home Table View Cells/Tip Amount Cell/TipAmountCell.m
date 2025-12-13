//
//  TipAmountCell.m
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import "TipAmountCell.h"
#import "CurrencyFormatter.h"

@implementation TipAmountCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        [self setupView];
        [self setConstraints];
    }
    
    return self;
}


- (void) setupView {
    self.tipAmountLabel = [[[UILabel alloc] init] autorelease];
    self.tipAmountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tipAmountLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    self.tipAmountLabel.text = [CurrencyFormatter localizedCurrencyStringFromDouble: 0];
    self.tipAmountLabel.numberOfLines = 0;
    
    // Accessibility Labels
    
    [self.contentView addSubview: self.tipAmountLabel];
}

- (void) setConstraints {
    [NSLayoutConstraint activateConstraints: @[
        [self.tipAmountLabel.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.tipAmountLabel.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.tipAmountLabel.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor],
        [self.tipAmountLabel.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void) dealloc {
    [_tipAmountLabel release];
    [super dealloc];
}

@end
