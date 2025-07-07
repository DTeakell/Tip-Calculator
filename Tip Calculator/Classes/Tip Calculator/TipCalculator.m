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
    double total = ((self.checkAmount + [self calculateTip]));
    return total;
}

- (double) calculateTipWithMultiplePeople {
    double tipSplit = ((self.checkAmount * (self.tipPercentage / 100)) / self.numberOfPeopleOnCheck);
    return tipSplit;
}

- (double) calculateTotalWithMultiplePeople {
    double totalSplit = ((self.checkAmount + [self calculateTip]) / self.numberOfPeopleOnCheck);
    return totalSplit;
}

@end
