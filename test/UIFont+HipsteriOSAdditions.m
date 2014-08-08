//
//  UIFont+HipsteriOSAdditions.m
//  test
//
//  Created by Rockstar. on 8/6/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "UIFont+HipsteriOSAdditions.h"

NSString *const kHSIFontRegularKey = @"Regular";
NSString *const kHSIFontItalicKey = @"Italic";
NSString *const kHSIFontBoldKey = @"Bold";
NSString *const kHSIFontBoldItalicKey = @"BoldItalic";
NSString *const kCDIFontHelveticaNeueKey = @"HelveticaNeue";

@implementation UIFont (HipsteriOSAdditions)

#pragma mark - Font Name
+ (NSDictionary *)hipsterFontMapForFontKey:(NSString *)key {
	static NSDictionary *fontDictionary = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		fontDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
						  [[NSDictionary alloc] initWithObjectsAndKeys:
						   @"HelveticaNeue", kHSIFontRegularKey,
						   @"HelveticaNeue-Italic", kHSIFontItalicKey,
						   @"HelveticaNeue-Bold", kHSIFontBoldKey,
						   @"HelveticaNeue-BoldItalic", kHSIFontBoldItalicKey,
						   nil], kCDIFontHelveticaNeueKey,
						  nil];
	});
	return [fontDictionary objectForKey:key];
}


+ (NSString *)hipsterFontNameForFontKey:(NSString *)key style:(NSString *)style {
    return [[self hipsterFontMapForFontKey:key] objectForKey:style];
}

#pragma mark - Fonts

+ (UIFont *)hipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
    NSString *fontName = [self hipsterFontNameForFontKey:key style:kHSIFontRegularKey];
    return [self fontWithName:fontName size:fontSize];
    
}
+ (UIFont *)boldHipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
    NSString *fontName = [self hipsterFontNameForFontKey:key style:kHSIFontBoldKey];
    return [self fontWithName:fontName size:fontSize];
    
}
+ (UIFont *)boldItalicHipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
    NSString *fontName = [self hipsterFontNameForFontKey:key style:kHSIFontBoldItalicKey];
    return [self fontWithName:fontName size:fontSize];
    
}
+ (UIFont *)italicHipsterFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
    NSString *fontName = [self hipsterFontNameForFontKey:key style:kHSIFontItalicKey];
    return [self fontWithName:fontName size:fontSize];
}

#pragma mark - Interface

+ (UIFont *)hipsterInterfaceFontOfSize:(CGFloat)fontSize {
    return [self fontWithName:kHSIRegularFontName size:fontSize];
    
}

+ (UIFont *)boldHipsterInterfaceFontOfSize:(CGFloat)fontSize {
    return [self fontWithName:kHSIBoldFontName size:fontSize];
    
}

@end
