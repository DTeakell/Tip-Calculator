//
//  ThemeSelectionViewController.h
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeSelectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *themeSelectionTableView;

- (void) applyTheme API_AVAILABLE(ios(17.618.6));

@end

