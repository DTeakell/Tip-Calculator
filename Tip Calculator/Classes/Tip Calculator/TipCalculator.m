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
    return (self.checkAmount * (self.tipPercentage / 100));
}

- (double) calculateTotal {
    return ((self.checkAmount + [self calculateTip]));
}

- (double) calculateTipWithMultiplePeople {
    return ((self.checkAmount * (self.tipPercentage / 100)) / self.numberOfPeopleOnCheck);
}

- (double) calculateTotalWithMultiplePeople {
    return ((self.checkAmount + [self calculateTip]) / self.numberOfPeopleOnCheck);
}

- (double) roundUp: (double) x {
    return ceil(x);
}

- (void) reset {
    self.checkAmount = 0;
    self.numberOfPeopleOnCheck = 0;
    self.tipPercentage = 0;
}

@end
