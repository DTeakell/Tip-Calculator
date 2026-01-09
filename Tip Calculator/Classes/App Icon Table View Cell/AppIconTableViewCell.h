//
//  AppIconCell.h
//  Tip
//
//  Created by Dillon Teakell on 1/9/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppIconTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *appIconImage;
@property (nonatomic, retain) UILabel *appIconDisplayNameLabel;
@property (nonatomic, retain) UIImageView *checkmark;

@end
