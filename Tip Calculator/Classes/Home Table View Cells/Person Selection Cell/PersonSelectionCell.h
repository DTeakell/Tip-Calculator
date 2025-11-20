//
//  PersonSelectionCell.h
//  Tip
//
//  Created by Dillon Teakell on 7/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonSelectionCell : UITableViewCell

@property (nonatomic, retain) UITextField *numberOfPeopleTextField;

- (void) applyTheme;

@end

NS_ASSUME_NONNULL_END
