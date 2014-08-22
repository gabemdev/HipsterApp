//
//  SettingsViewController.m
//  Hipster
//
//  Created by Rockstar. on 8/13/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIFont+HipsteriOSAdditions.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "UIButton+HipsteriOSAdditions.h"
#import "AppDelegate.h"
#import "SignInViewController.h"
#import "CDKUser.h"
#import "splitViewController.h"
#import "ListViewController.h"
#import "AccountViewController.h"
#import "GMWebViewController.h"
#import <Parse/Parse.h>
#import <GMDLibrary/GreenView.h>

NSString *const kCDIFontDidChangeNotificationName = @"CDIFontDidChangeNotification";

@interface SettingsViewController ()
@property (nonatomic, strong) UILabel *upgradeLabel;
@property (nonatomic, strong) UIButton *upgradeButton;
@property (nonatomic) UIImageView *avatarImageView;

@end

@implementation SettingsViewController

@synthesize upgradeLabel = _upgradeLabel;

- (instancetype)init {
    if ((self = [super init])) {
        [self.view addSubview:self.avatarImageView];
    }
    return self;
}

- (UIImageView *)avatarImageView {
	if (!_avatarImageView) {
		_avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 12.0f)];
		_avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
		_avatarImageView.layer.borderColor = [[self class] darkTextColor].CGColor;
		_avatarImageView.layer.borderWidth = 1.0f;
		_avatarImageView.layer.masksToBounds = YES;
		_avatarImageView.backgroundColor = [UIColor redColor];
		_avatarImageView.userInteractionEnabled = NO;
        _avatarImageView.image = [UIImage imageNamed:@"list-icon"];
        
	}
	return _avatarImageView;
}

- (UILabel *)upgradeLabel {
    if (!_upgradeLabel) {
        _upgradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 60.0f)];
        _upgradeLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
        _upgradeLabel.backgroundColor = [UIColor clearColor];
        _upgradeLabel.textAlignment = NSTextAlignmentCenter;
        _upgradeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _upgradeLabel.numberOfLines = 2;
        _upgradeLabel.textColor = [UIColor hipsterOrangeColor];
        _upgradeLabel.userInteractionEnabled = YES;
    }
    
    return _upgradeLabel;
}

- (UIButton *)upgradeButton {
    if (!_upgradeButton) {
//        _upgradeButton = [UIButton hipsterBigOrangeButton];
        _upgradeButton = [[UIButton alloc] init];
//        _upgradeButton.backgroundColor = [UIColor colorWithRed:0.031f green:0.506f blue:0.702f alpha:1.0f];
        _upgradeButton.backgroundColor = [UIColor hipsterBlueColor];
        _upgradeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _upgradeButton.frame = CGRectMake(roundf((self.view.frame.size.width - 300.0f) / 2.0f), 66.0f, 300.0f, 32.0f);
        _upgradeButton.layer.cornerRadius = 3;
        [_upgradeButton setTitle:@"Upgrade" forState:UIControlStateNormal];
        [_upgradeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_upgradeButton setTitleColor:[UIColor hipsterLightTextColor] forState:UIControlStateHighlighted];
        [_upgradeButton addTarget:self action:@selector(upgrade:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_upgradeButton];
    }
    return _upgradeButton;
}

#pragma mark - NSObject
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    GreenView *green = [[GreenView alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 200.0f, 200.0f)];
    [self.view addSubview:green];
    
    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 32.0f)];
    footer.backgroundColor = [UIColor clearColor];
    footer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    footer.textAlignment = NSTextAlignmentCenter;
    footer.textColor = [UIColor hipsterLightTextColor];
    footer.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
    footer.text = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    footer.shadowColor = [UIColor whiteColor];
    footer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.tableView.tableFooterView = footer;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _updateUI];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)upgrade:(id)sender {
    
}

- (void)signOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Out" message:@"Are you sure you want to sign out of Hipster" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Out", nil];
    [alert show];
}

#pragma mark - Private
- (void)_updateUI {
    CDKUser *user = [CDKUser currentUser];
    if (user.hasPlus.boolValue) {
        self.upgradeLabel.text = @"You have Hipster Pro and we really love you for that";
        _upgradeButton.alpha = 0.0f;
    } else {
        self.upgradeLabel.text = @"";
        self.upgradeButton.alpha = 1.0f;
    }
}

#pragma mark - UIAlerViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex !=1) {
        return;
    }
    
    //SIgn Out
    [CDKUser setCurrentUser:nil];
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        appDelegate.window.rootViewController = [[splitViewController alloc] init];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]];
        appDelegate.window.rootViewController = nav;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Account
    if (section == 0) {
		return 1;
	}
    
//	// Display
//	else if (section == 1) {
//		return 2;
//	}
    
	// Tasks
	else if (section == 1) {
		return 1;
	}
    
	// About and Support
	else if (section == 2) {
		return 2;
	}
    
	// Sign out
	else if (section == 3) {
		return 1;
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"None";
	NSUInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
	if (numberOfRows == 1) {
		cellIdentifier = @"Both";
	} else if (indexPath.row == 0) {
		cellIdentifier = @"Top";
	} else if (indexPath.row == numberOfRows - 1) {
		cellIdentifier = @"Bottom";
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
	// Account
	if (indexPath.section == 0) {
		cell.textLabel.text = @"Manage Account";
//        cell.imageView.image = [UIImage imageNamed:@"personal"];
        cell.imageView.image = [UIImage imageNamed:@"more-icon-groupgift"];
        cell.textLabel.textColor = [UIColor hipsterBlueColor];
		cell.detailTextLabel.text = nil;
	}
    
//	// Display
//	else if (indexPath.section == 1) {
//		if (indexPath.row == 0) {
//			cell.textLabel.text = @"Text Size";
//            cell.textLabel.textColor = [UIColor hipsterTextColor];
//			cell.detailTextLabel.text = @"NIl";
//		}
//        else if (indexPath.row == 1) {
//			cell.textLabel.text = @"Font";
//            cell.textLabel.textColor = [UIColor hipsterTextColor];
//			cell.detailTextLabel.text = @"NIl";
//		}
//	}
//	
	// Tasks
	else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"About Hipster";
            cell.textLabel.textColor = [UIColor hipsterBlueColor];
//            cell.imageView.image = [UIImage imageNamed:@"star"];
            cell.imageView.image = [UIImage imageNamed:@"more-icon-terms"];
			cell.detailTextLabel.text = nil;
		}
	}
	
	// About and Support
	else if (indexPath.section == 2) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"Privacy";
            cell.textLabel.textColor = [UIColor hipsterSteelColor];
//            cell.imageView.image = [UIImage imageNamed:@"locks"];
            cell.imageView.image = [UIImage imageNamed:@"more-icon-privacy"];
			cell.detailTextLabel.text = nil;
		} else if (indexPath.row == 1) {
			cell.textLabel.text = @"Get Help";
            cell.textLabel.textColor = [UIColor hipsterOrangeColor];
//            cell.imageView.image = [UIImage imageNamed:@"mail"];
            cell.imageView.image = [UIImage imageNamed:@"more-icon-help"];
			cell.detailTextLabel.text = nil;
		}
	}
    
	// Sign out
	else if (indexPath.section == 3) {
		cell.textLabel.text = @"Sign Out";
        cell.textLabel.textColor = [UIColor redColor];
//        cell.imageView.image = [UIImage imageNamed:@"x"];
        cell.imageView.image = [UIImage imageNamed:@"more-icon-signout"];
		cell.detailTextLabel.text = nil;
	}
    
	return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section != 0) {
        return nil;
    }
    return  self.upgradeLabel;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if (section != 0) {
        return 0.0f;
    }
    
    return 60.0f;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Account";
    }
//    else if (section == 1) {
//        return @"Display";
//    }
    else if (section == 1) {
        return @"About";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    
    //Account
    if (indexPath.section == 0) {
        viewController = [[AccountViewController alloc] init];
    }
    //About
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            GMWebViewController *viewController = [[GMWebViewController alloc] init];
            [viewController loadURL:[NSURL URLWithString:@"http://gabemdev.com"]];
            [self.navigationController pushViewController:viewController animated:YES];
            return;
        }
    }
//Privacy and Support
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
#pragma message ("Add View controlelr for Privacy")
            return;
        } else if (indexPath.row == 1) {
#pragma message ("Add View Controller for Support")
            return;
        }
    }
    
    else if (indexPath.section == 3) {
        [PFUser logOut];
        [self signOut:nil];
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

+ (UIColor *)darkTextColor {
	return [UIColor colorWithRed:0.949f green:0.510f blue:0.380f alpha:1.0f];
}


@end
