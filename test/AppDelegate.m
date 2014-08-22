//
//  AppDelegate.m
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "AppDelegate.h"
#import "splitViewController.h"
#import "ListViewController.h"
#import "SignInViewController.h"
#import "ListTableViewController.h"
#import "MainViewController.h"
#import <Parse/Parse.h>
#import "FeedViewController.h"
#import <GMDLibrary/Greenview.h>



@implementation AppDelegate

@synthesize window = _window;
@synthesize splitViewController = _splitViewController;

+ (AppDelegate *)sharedAppDelegate {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [Parse setApplicationId:@"pM9NqdVLuLZwlx053n1pTH4jShYNPMhqqwtRCd4W"
                  clientKey:@"91xPVaLZ3r54RumCGkWijCiVM7RxkEpn5UEp9O9O"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self applyStylesheet];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
//        ListTableViewController *leftVC = [[ListTableViewController alloc] initWithStyle:UITableViewStylePlain];
//        UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
//        
//        MainViewController *mainVC = [[MainViewController alloc] init];
//        UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
//        
//        leftVC.detailView = mainVC;
//        
//        
//        _splitViewController = [[UISplitViewController alloc] init];
//        _splitViewController.viewControllers = @[leftNav, mainNav];
//        _splitViewController.delegate = mainVC;
//        self.window.rootViewController = _splitViewController;
//        self.window.backgroundColor = [UIColor whiteColor];
        
//        _splitViewController = [[UISplitViewController alloc] init];
//        
//        ListTableViewController *root = [[ListTableViewController alloc] init];
//        MainViewController *detail = [[MainViewController alloc] init];
//        
//        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:root];
//        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detail];
//        
//        _splitViewController.viewControllers = [NSArray arrayWithObjects:rootNav, detailNav, nil];
//        _splitViewController.delegate = detail;
        
        self.window.rootViewController = [[splitViewController alloc] init];
        
	} else {
        
		UIViewController *viewController = [[FeedViewController alloc] init];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationController.navigationBar setTranslucent:NO];
		self.window.rootViewController = navigationController;
	}
    
    [self.window makeKeyAndVisible];
    
    // Defer some stuff to make launching faster
	dispatch_async(dispatch_get_main_queue(), ^{
		// Setup status bar network indicator
		[AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
		// Set the OAuth client
//		[[CDKHTTPClient sharedClient] setClientID:kCDIAPIClientID secret:kCDIAPIClientSecret];
		
		// Initialize the connection to Pusher
//		[CDKPushController sharedController];
		
		// Add the transaction observer
//		[[SKPaymentQueue defaultQueue] addTransactionObserver:[CDITransactionObserver defaultObserver]];
	});
    
    return YES;
}

#pragma mark - Stylesheet

- (void)applyStylesheet {
    //status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
	// Navigation bar
	UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarStyle:UIBarStyleBlack];
    
    [navigationBar setBarTintColor:[UIColor colorWithRed:0.031f green:0.506f blue:0.702f alpha:1.0f]];
	[navigationBar setTitleVerticalPositionAdjustment:-1.0f forBarMetrics:UIBarMetricsDefault];
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.2f]];
    [shadow setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Oswald-Bold" size:20.0f],
                                            NSShadowAttributeName: shadow,
                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                            }];
	
	// Navigation bar mini
	[navigationBar setTitleVerticalPositionAdjustment:-2.0f forBarMetrics:UIBarMetricsLandscapePhone];
	
//	// Navigation button
//    NSDictionary *barButtonTitleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14.0f],
//                                                   NSShadowAttributeName: shadow};
//    
//	UIBarButtonItem *barButton = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
//	[barButton setTitlePositionAdjustment:UIOffsetMake(0.0f, 1.0f) forBarMetrics:UIBarMetricsDefault];
//	[barButton setTitleTextAttributes:barButtonTitleTextAttributes forState:UIControlStateNormal];
//	[barButton setTitleTextAttributes:barButtonTitleTextAttributes forState:UIControlStateHighlighted];
//	[barButton setBackgroundImage:[[UIImage imageNamed:@"nav-button"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//	[barButton setBackgroundImage:[[UIImage imageNamed:@"nav-button-highlighted"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//	
//	// Navigation back button
//	[barButton setBackButtonTitlePositionAdjustment:UIOffsetMake(2.0f, -2.0f) forBarMetrics:UIBarMetricsDefault];
//	[barButton setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav-back"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//	[barButton setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav-back-highlighted"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//	
//	// Navigation button mini
//	//	[barButton setTitlePositionAdjustment:UIOffsetMake(0.0f, 1.0f) forBarMetrics:UIBarMetricsLandscapePhone];
//	[barButton setBackgroundImage:[[UIImage imageNamed:@"nav-button-mini"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
//	[barButton setBackgroundImage:[[UIImage imageNamed:@"nav-button-mini-highlighted"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
//	
//	// Navigation back button mini
//	[barButton setBackButtonTitlePositionAdjustment:UIOffsetMake(2.0f, -2.0f) forBarMetrics:UIBarMetricsLandscapePhone];
//	[barButton setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav-back-mini"] stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
//	[barButton setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav-back-mini-highlighted"] stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
	
	// Toolbar
	UIToolbar *toolbar = [UIToolbar appearance];
    [toolbar setBarTintColor:[UIColor colorWithRed:0.031f green:0.506f blue:0.702f alpha:1.0f]];
    
    
//	[toolbar setBackgroundImage:[UIImage imageNamed:@"navigation-background"] forToolbarPosition:UIToolbarPositionTop barMetrics:UIBarMetricsDefault];
//	[toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar-background"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
//    [toolbar setBackgroundColor:[UIColor colorWithRed:0.031f green:0.506f blue:0.702f alpha:1.0f]];
    
	
	// Toolbar mini
//	[toolbar setBackgroundImage:[UIImage imageNamed:@"navigation-background-mini"] forToolbarPosition:UIToolbarPositionTop barMetrics:UIBarMetricsLandscapePhone];
//	[toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar-background-mini"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsLandscapePhone];
    
}

@end
