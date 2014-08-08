//
//  TableViewCellDelegateConfirmationConrol.m
//  test
//
//  Created by Rockstar. on 8/5/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "TableViewCellDelegateConfirmationConrol.h"
#import <objc/runtime.h>

@implementation TableViewCellDelegateConfirmationConrol

- (void)drawRectCustom:(CGRect)rect {
	UIImage *image = nil;
	if (self.highlighted) {
		image = [UIImage imageNamed:@"archive-button-highlighted"];
	} else {
		image = [UIImage imageNamed:@"archive-button"];
	}
	[[image stretchableImageWithLeftCapWidth:5 topCapHeight:0] drawInRect:rect];
    
	NSString *text = [self valueForKey:@"title"];
	UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
//	UILineBreakMode lineBreakMode = UILineBreakModeClip;
    NSLineBreakMode lineBreakMode = NSLineBreakByClipping;
//	UITextAlignment alignment = UITextAlignmentCenter;
    NSTextAlignment alignment = NSTextAlignmentCenter;
    
	rect.origin.y += 8.0f;
	[[UIColor colorWithRed:0.588f green:0.090f blue:0.125f alpha:1.0f] set];
	[text drawInRect:rect withFont:font lineBreakMode:lineBreakMode alignment:alignment];
    [text drawInRect:rect withAttributes:@{NSFontAttributeName: font}];
    
	[[UIColor whiteColor] set];
	rect.origin.y -= 1.0f;
	[text drawInRect:rect withFont:font lineBreakMode:lineBreakMode alignment:alignment];
}

@end
