//
//  UIButton+HipsteriOSAdditions.m
//  test
//
//  Created by Rockstar. on 8/6/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "UIButton+HipsteriOSAdditions.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "UIFont+HipsteriOSAdditions.h"

@implementation UIButton (HipsteriOSAdditions)

+ (UIButton *)hipsterBigButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setBackgroundImage:[[UIImage imageNamed:@"big-button"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"big-button-highlighted"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:0.384 green:0.412 blue:0.455 alpha:1] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:18.0f];
    return button;
}


+ (UIButton *)hipsterBigOrangeButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setBackgroundImage:[[UIImage imageNamed:@"big-orange-button"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"big-orange-button-highlighted"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.2f] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:20.0f];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.titleEdgeInsets = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0f);
    return button;
    
}

+ (UIButton *)hipsterBigGrayButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setBackgroundImage:[[UIImage imageNamed:@"big-gray-button"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"big-gray-button-highlighted"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor hipsterSteelColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:20.0f];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.titleEdgeInsets = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0f);
    return button;
    
}

+ (UIButton *)hipsterBarButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.2f] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"nav-button"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"nav-button-highlighted"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    return button;
}

+ (UIButton *) hipsterProfileButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setTitleColor:[UIColor hipsterTextColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.2f] forState:UIControlStateNormal];
//    [button setBackgroundImage:[[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
//    [button setBackgroundImage:[[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    return button;
    
}

@end
