//
//  TipCalculator.h
//  Tip Calculator
//
//  Created by Dillon Teakell on 5/20/25.
//
//
//  Tip Calculator Interface
//
@interface TipCalculator : NSObject

@property (nonatomic) double checkAmount;
@property (nonatomic) double tipPercentage;

- (double) calculateTotal;

- (double) calculateTip;

@end
