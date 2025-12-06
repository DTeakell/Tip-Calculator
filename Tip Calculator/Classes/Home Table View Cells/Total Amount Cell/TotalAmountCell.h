//
//  TotalAmountCell.h
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import <UIKit/UIKit.h>
#import "SettingsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TotalAmountCell : UITableViewCell

@property (nonatomic, retain) UIStackView *totalStackView;
@property (nonatomic, retain) UILabel *checkTotalLabel;
@property (nonatomic, retain) UILabel *roundedTotalLabel;
@property (nonatomic, retain) UIImageView *upArrowImageView;

- (void) applyTheme;

- (void) applyTheme;

@end

NS_ASSUME_NONNULL_END
