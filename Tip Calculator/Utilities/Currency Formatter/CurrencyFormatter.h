//
//  CurrencyFormatter.h
//  Tip
//
//  Created by Dillon Teakell on 7/7/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Creates a currency string object that is local to the device's region.
@interface CurrencyFormatter : NSObject

/// Localizes a currency string to match the user's device region.
+ (NSString *) localizedCurrencyStringFromDouble: (double) value;

/// Localizes the "per person" segment of the currency string.
+ (NSString *) localizedPerPersonStringFromDouble: (double) value;


@end

NS_ASSUME_NONNULL_END
