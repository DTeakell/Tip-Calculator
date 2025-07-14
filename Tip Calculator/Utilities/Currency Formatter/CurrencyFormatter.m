//
//  CurrencyFormatter.m
//  Tip
//
//  Created by Dillon Teakell on 7/7/25.
//

#import "CurrencyFormatter.h"

@implementation CurrencyFormatter

+ (NSString *) localizedCurrencyStringFromDouble: (double) value {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = [NSLocale currentLocale];
    NSString *currencyString = [formatter stringFromNumber: @(value)];
    [formatter release];
    return currencyString;
    
}

+ (NSString *) localizedPerPersonStringFromDouble: (double) value {
    NSString *currency = [self localizedCurrencyStringFromDouble: value];
    NSString *perPersonString = NSLocalizedString(@"per person", @"Label for amount per person");
    return [NSString stringWithFormat: @"%@ %@", currency, perPersonString];
}

@end
