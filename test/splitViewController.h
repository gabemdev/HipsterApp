//
//  splitViewController.h
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

@class ListViewController;
@class ListTableViewController;
@class MainViewController;

@interface splitViewController : UISplitViewController

+ (splitViewController *)sharedSplitViewController;

@property (nonatomic, strong, readonly) ListViewController *listsViewController;
@property (nonatomic, strong, readonly) MainViewController *mainViewController;
@property (nonatomic, strong, readonly) ListTableViewController *listTableViewController;

@end
