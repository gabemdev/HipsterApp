//
//  UIFont+HipsteriOSAdditions.h
//  test
//
//  Created by Rockstar. on 8/6/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

extern NSString *const kHSIFontRegularKey;
extern NSString *const kHSIFontItalicKey;
extern NSString *const kHSIFontBoldKey;
extern NSString *const kHSIFontBoldItalicKey;

@interface UIFont (HipsteriOSAdditions)

#pragma mark - Font Names

+ (NSDictionary *)hipsterFontMapForFontKey:(NSString *)key;
+ (NSString *)hipsterFontNameForFontKey:(NSString *)key style:(NSString *)style;

#pragma mark - Fonts

+ (UIFont *)hipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)boldHipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)boldItalicHipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)italicHipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;

//#pragma mark - Standard
//
//+ (UIFont *)hipsterFontOfSize:(CGFloat)fontSize;
//+ (UIFont *)boldHipsterFontOfSize:(CGFloat)fontSize;
//+ (UIFont *)boldItalicHipsterFontOfSize:(CGFloat)fontSize;
//+ (UIFont *)italicHipsterFontOfSize:(CGFloat)fontSize;

#pragma mark - Interface

+ (UIFont *)hipsterInterfaceFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldHipsterInterfaceFontOfSize:(CGFloat)fontSize;

@end
