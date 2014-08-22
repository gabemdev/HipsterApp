//
//  UIColor+HipsteriOSAdditions.m
//  test
//
//  Created by Rockstar. on 8/6/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "UIColor+HipsteriOSAdditions.h"

@implementation UIColor (HipsteriOSAdditions)

+ (UIColor *)hipsterArchesColor {
    return [self colorWithPatternImage:[UIImage imageNamed:@"arches"]];
}

+ (UIColor *)hipsterStaticColor {
    return [self colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

+ (UIColor *)hipsterTextColor {
    return [self colorWithWhite:0.267f alpha:1.0f];
}

+ (UIColor *)hipsterLightTextColor {
    return [self colorWithWhite:0.651f alpha:1.0f];
}

+ (UIColor *)hipsterBlueColor {
    return [self colorWithRed:0.031f green:0.506f blue:0.702f alpha:1.0f];
}

+ (UIColor *)hipsterSteelColor {
    return [self colorWithRed:0.376f green:0.408f blue:0.463f alpha:1.0f];
}

+ (UIColor *)hipsterHighlightColor {
    return [self colorWithRed:1.000f green:0.996f blue:0.792f alpha:1.0f];
}

+ (UIColor *)hipsterOrangeColor {
    return [self colorWithRed:1.000f green:0.447f blue:0.263f alpha:1.0f];
}

+ (UIColor *)hipsterLightGrayColor {
    return [self colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00];
}

@end
