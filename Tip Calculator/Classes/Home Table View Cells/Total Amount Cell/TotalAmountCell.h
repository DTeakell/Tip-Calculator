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

@property (nonatomic, retain) UILabel *checkTotalLabel;

- (void) applyTheme;

@end

NS_ASSUME_NONNULL_END
