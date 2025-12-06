//
//  TipPercentageSelectorCell.h
//  Tip
//
//  Created by Dillon Teakell on 6/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipPercentageSelectorCell : UITableViewCell

@property (nonatomic, retain) UISegmentedControl *tipPercentageSelector;
@property (nonatomic, assign) NSInteger selectedTipIndex;

- (void) applyTheme;

@end

NS_ASSUME_NONNULL_END
