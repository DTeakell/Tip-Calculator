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
@property (nonatomic) int numberOfPeopleOnCheck;
@property (nonatomic) double roundedCheckTotalValue;

/// Calculates the tip of the check
- (double) calculateTip;

/// Calculates the total amount including the tip
- (double) calculateTotal;

/// Calculates the tip based on the number of people selected
- (double) calculateTipWithMultiplePeople;

/// Calculates the total based on the number of people selected
- (double) calculateTotalWithMultiplePeople;


/// Rounds a `double` value to the next whole number
///
/// `156.22 -> 157.00`
- (double) roundUp: (double) x;


/// Resets all properties to `0`.
- (void) reset;

@end
