//
//  main.m
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "TableViewCellDelegateConfirmationConrol.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

int main(int argc, char * argv[])
{
    @autoreleasepool {
        // Swizzle archive button
		Class deleteControl = NSClassFromString([NSString stringWithFormat:@"_%@DeleteConfirmationControl", @"UITableViewCell"]);
		if (deleteControl) {
			Method drawRect = class_getInstanceMethod(deleteControl, @selector(drawRect:));
			Method drawRectCustom = class_getInstanceMethod([TableViewCellDelegateConfirmationConrol class], @selector(drawRectCustom:));
			method_exchangeImplementations(drawRect, drawRectCustom);
		}
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
