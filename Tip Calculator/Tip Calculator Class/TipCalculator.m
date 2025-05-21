//
//  TipCalculator.m
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//

#import <Foundation/Foundation.h>
#import "TipCalculator.h"

@implementation TipCalculator

- (double) calculateTip {
    return self.checkAmount * (self.tipPercentage / 100);
}

- (double)calculateTotal {
    double total = self.checkAmount + [self calculateTip];
    return total;
}

@end
