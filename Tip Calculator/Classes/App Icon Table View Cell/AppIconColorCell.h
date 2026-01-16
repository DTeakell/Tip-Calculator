//
//  ColorCell.h
//  Tip
//
//  Created by Dillon Teakell on 11/12/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppIconColorCell : UITableViewCell

@property (nonatomic, retain) UIImageView *appIconImage;
@property (nonatomic, retain) NSString *appIconImageName;
@property (nonatomic, retain) UILabel *colorLabel;
@property (nonatomic, retain) UIImageView *checkmark;

@end
