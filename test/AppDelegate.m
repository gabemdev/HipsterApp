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
#import "UIColor+HipsteriOSAdditions.h"
#import "AFNetworkActivityIndicatorManager.h"
//#import <GMDLibrary/GMDLibrary.h>



@implementation AppDelegate

@synthesize window = _window;
@synthesize splitViewController = _splitViewController;

+ (AppDelegate *)sharedAppDelegate {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURLCache *URlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URlCache];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [Parse setApplicationId:@"pM9NqdVLuLZwlx053n1pTH4jShYNPMhqqwtRCd4W"
                  clientKey:@"91xPVaLZ3r54RumCGkWijCiVM7RxkEpn5UEp9O9O"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
	
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
        
        [self applyStylesheet];
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
    
    [navigationBar setBarTintColor:[UIColor hipsterBlueColor]];
	[navigationBar setTitleVerticalPositionAdjustment:-1.0f forBarMetrics:UIBarMetricsDefault];
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.2f]];
    [shadow setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Oswald-Bold" size:20.0f],
                                            NSShadowAttributeName: shadow,
                                            NSForegroundColorAttributeName: [UIColor whiteColor]
                                            }];
	
	// Navigation bar mini
	[navigationBar setTitleVerticalPositionAdjustment:-2.0f forBarMetrics:UIBarMetricsLandscapePhone];
	
	// Toolbar
	UIToolbar *toolbar = [UIToolbar appearance];
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar setBarTintColor:[UIColor hipsterBlueColor]];
    [toolbar setBackgroundColor:[UIColor hipsterBlueColor]];

    
}

@end
