//
//  AppDelegate.h
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UISplitViewController *splitViewController;

+ (AppDelegate *)sharedAppDelegate;
- (void)applyStylesheet;

@end
