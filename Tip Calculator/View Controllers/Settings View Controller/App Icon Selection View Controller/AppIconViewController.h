//
//  AppIconViewController.h
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppIconViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *appIconTableView;

@end
