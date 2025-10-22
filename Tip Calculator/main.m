//
//  main.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SceneDelegate.h"

int main(int argc, char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    int returnValue = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    
    [pool drain];
    
    return returnValue;
}
