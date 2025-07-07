//
//  Tip_CalculatorTests.m
//  Tip CalculatorTests
//
//  Created by Dillon Teakell on 5/20/25.
//

#import <XCTest/XCTest.h>
#import "TipCalculator.h"

@interface Tip_CalculatorTests : XCTestCase

@end

@implementation Tip_CalculatorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testCheckAmountZero {
    TipCalculator *tipCalculator = [[TipCalculator alloc] init];
    tipCalculator.checkAmount = 0;
    tipCalculator.tipPercentage = 20;
    double tip = [tipCalculator calculateTip];
    double total = [tipCalculator calculateTotal];
    XCTAssertEqualWithAccuracy(tip, 0, 0.0001);
    XCTAssertEqualWithAccuracy(total, 0, 0.0001);
}

- (void) testTotalCalculation {
    TipCalculator *tipCalculator = [[TipCalculator alloc] init];
    tipCalculator.checkAmount = 100;
    tipCalculator.tipPercentage = 20;
    double total = [tipCalculator calculateTotal];
    XCTAssertEqualWithAccuracy(total, 120, 0.001);
}

- (void) testTipCalculation {
    TipCalculator *tipCalculator = [[TipCalculator alloc] init];
    tipCalculator.checkAmount = 100;
    tipCalculator.tipPercentage = 20;
    double tip = [tipCalculator calculateTip];
    XCTAssertEqualWithAccuracy(tip, 20, 0.001);
}

- (void) testTipCalculationWithMultiplePeople {
    TipCalculator *tipCalculator = [[TipCalculator alloc] init];
    tipCalculator.checkAmount = 100;
    tipCalculator.tipPercentage = 20;
    tipCalculator.numberOfPeopleOnCheck = 2;
    double tip = [tipCalculator calculateTip];
    XCTAssertEqualWithAccuracy(tip, 10, 0.001);
}

- (void) testTotalCalculationWithMultiplePeople {
    TipCalculator *tipCalculator = [[TipCalculator alloc] init];
    tipCalculator.checkAmount = 200;
    tipCalculator.tipPercentage = 10;
    tipCalculator.numberOfPeopleOnCheck = 2;
    double total = [tipCalculator calculateTotal];
    XCTAssertEqualWithAccuracy(total, 110, 0.001);
}

@end
