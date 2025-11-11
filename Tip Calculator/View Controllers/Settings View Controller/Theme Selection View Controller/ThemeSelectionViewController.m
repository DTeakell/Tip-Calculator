//
//  ThemeSelectionViewController.m
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import "ThemeSelectionViewController.h"

@implementation ThemeSelectionViewController

- (void)loadView {
    UIView *themeSelectionView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.view = themeSelectionView;
    [themeSelectionView release];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = @"Theme Color";
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        while ([cell.contentView.subviews count] > 0) {
            [[[cell.contentView subviews] lastObject] removeFromSuperview];
        }
    }
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



@end
