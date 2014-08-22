//
//  FeedViewController.m
//  Hipster
//
//  Created by Rockstar. on 8/14/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "FeedViewController.h"
#import "SettingsViewController.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "SignInViewController.h"
#import "FeedCell.h"
#import <Parse/Parse.h>

@interface FeedViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *settings;
@property (nonatomic) NSArray *photos;

@end

@implementation FeedViewController
@synthesize label = _label;

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 42.0f)];
    }
    return _label;
    
    
}

- (instancetype)init {
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(settings:)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menu:)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(300.0, 150.0);
        layout.minimumInteritemSpacing = 10.0;
        layout.minimumLineSpacing = 10.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HIPSTER";
    
    self.view.backgroundColor = [UIColor hipsterStaticColor];
    
    [self.collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.frame = CGRectMake(0.0f, 10.0f, self.view.frame.size.width, (self.view.frame.size.height - 10));
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(settings:)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		[self _checkUser];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self _checkUser];
	}
	
}

- (void)settings:(id)sender {
    SettingsViewController *view = [[SettingsViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

- (void)menu:(id)sender {
    
}

#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor hipsterBlueColor];
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}

#pragma mark - Private

- (void)_checkUser {
    PFUser *currentUser = [PFUser currentUser];
	if (!currentUser) {
		UIViewController *viewController = [[SignInViewController alloc] init];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
		navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.splitViewController presentViewController:navigationController animated:YES completion:nil];
		} else {
            
            [self.navigationController presentViewController:navigationController animated:NO completion:nil];
            NSLog(@"Current user: %@", currentUser.username);
        }
        return;
	}
}

@end
