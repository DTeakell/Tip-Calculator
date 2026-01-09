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
    
}

// TODO: Finish Constraints
- (void) setConstraints {
    
}



@end
