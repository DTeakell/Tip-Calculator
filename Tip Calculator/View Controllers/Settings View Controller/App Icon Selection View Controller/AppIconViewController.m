//
//  AppIconViewController.m
//  Tip
//
//  Created by Dillon Teakell on 11/4/25.
//

#import "AppIconViewController.h"

@implementation AppIconViewController

- (void) loadView {
    UIView *appIconView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.view = appIconView;
    [appIconView release];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.title = @"App Icon";
}


@end
