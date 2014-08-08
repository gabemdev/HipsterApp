//
//  splitViewController.m
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "splitViewController.h"
#import "AppDelegate.h"
#import "ListViewController.h"
#import "MainViewController.h"
#import "ListTableViewController.h"

@interface splitViewController () <UISplitViewControllerDelegate>

@end

@implementation splitViewController

@synthesize listsViewController = _listsViewController;
@synthesize listTableViewController = _listTableViewController;
@synthesize mainViewController = _mainViewController;

#pragma mark - Class Methods

+ (splitViewController *)sharedSplitViewController {
	return (splitViewController *)[[[AppDelegate sharedAppDelegate] window] rootViewController];
}


#pragma mark - NSObject

- (id)init {
	if ((self = [super init])) {
		_listsViewController = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
        _mainViewController = [[MainViewController alloc] init];
        _listTableViewController = [[ListTableViewController alloc] initWithStyle:UITableViewStylePlain];
		
		self.viewControllers = [[NSArray alloc] initWithObjects:
								[[UINavigationController alloc] initWithRootViewController:_listsViewController],
                                [[UINavigationController alloc] initWithRootViewController:_mainViewController],
								nil];
		
		self.delegate = self;
	}
	return self;
}


#pragma mark - UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}


#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
	return NO;
}

@end
