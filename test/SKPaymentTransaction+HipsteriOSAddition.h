//
//  SKPaymentTransaction+HipsteriOSAddition.h
//  test
//
//  Created by Rockstar. on 8/6/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <StoreKit/StoreKit.h>

@interface SKPaymentTransaction (HipsteriOSAddition)

- (NSString *)transactionReceiptString;

@end
