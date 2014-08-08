//
//  MainViewController.m
//  test
//
//  Created by Rockstar. on 8/3/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"
#import "SignInViewController.h"
#import "CDKUser.h"

@interface MainViewController ()
//- (void)_checkUser;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation MainViewController
@synthesize masterPopoverController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSObject

- (id)init {
	if ((self = [super init])) {
//		_createTaskSemaphore = dispatch_semaphore_create(0);
//		dispatch_semaphore_signal(_createTaskSemaphore);
		
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tasks" style:UIBarButtonItemStyleBordered target:nil action:nil];
	}
	return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	
	if (!self.navigationItem.rightBarButtonItem) {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditMode:)];
	}
	self.navigationItem.rightBarButtonItem.title = editing ? @"Done" : @"Edit";
//	self.navigationItem.rightBarButtonItem.enabled = self.currentTags.count == 0 && self.list;
//	[self.addTaskView setEditing:editing animated:animated];
}


//- (void)viewWillAppear:(BOOL)animated {
//	[super viewWillAppear:animated];
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//		[self _checkUser];
//	}
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//	[super viewDidAppear:animated];
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//		[self _checkUser];
//	}
//	
//}
//
//- (void)_checkUser {
//	if (![CDKUser currentUser]) {
//		UIViewController *viewController = [[SignInViewController alloc] init];
//		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//		navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
//		
//		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            [self.splitViewController presentViewController:navigationController animated:YES completion:nil];
//		} else {
//            
//            [self.navigationController presentViewController:navigationController animated:NO completion:nil];
//		}
//		return;
//	}
//}

#pragma mark - splitview
- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
