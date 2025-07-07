//
//  NSNumber+Currency.m
//  Tip
//
//  Created by Dillon Teakell on 6/27/25.
//

#import "NSNumber+Currency.h"

@implementation NSNumber (Currency)

- (NSString *)localizedCurrencyString {
    // Create number formatter
    static NSNumberFormatter *currencyFormatter = nil;
        
    currencyFormatter = [[NSNumberFormatter alloc] init];
    
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    return [currencyFormatter stringFromNumber: self];
}

@end
