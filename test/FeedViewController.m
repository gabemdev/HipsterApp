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
#import "UIFont+HipsteriOSAdditions.h"
#import "SignInViewController.h"
#import "DetailViewController.h"
#import "PresentDetailTransition.h"
#import "DismissDetailTransition.h"
#import "FeedCell.h"
#import <Parse/Parse.h>


@interface FeedViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *settings;
@property (nonatomic) NSArray *photos;
//@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (instancetype)init {
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(300.0, 300.0);
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 0.0f);
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HIPSTER";
    [self loadNav];
//    [self makeFeedRequest];
    
//    _refreshControl = [[UIRefreshControl alloc] init];
//    [_refreshControl addTarget:self action:@selector(refresh)
//             forControlEvents:UIControlEventValueChanged];
//    _refreshControl.tintColor = [UIColor hipsterBlueColor];
//    [_refreshControl beginRefreshing];
//    [self.collectionView addSubview:_refreshControl];
//    self.collectionView.alwaysBounceVertical = YES;

    
    
    [self.collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor hipsterStaticColor];
    self.collectionView.delegate = self;
    [self loadPhotos];
    
//    self.collectionView.frame = CGRectMake(0.0f, 10.0f, self.view.frame.size.width, (self.view.frame.size.height - 10));
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
    [self.collectionView reloadData];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self _checkUser];
	}
	
}

#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = (FeedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    [cell.cellImage setImage:[UIImage imageNamed:[self.photos objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    DetailViewController *viewControler = [[DetailViewController alloc] init];
    viewControler.modalPresentationStyle = UIModalPresentationCustom;
    viewControler.transitioningDelegate = self;
    viewControler.photo = photo;
    
    [self presentViewController:viewControler animated:YES completion:nil];
    
}

#pragma mark - Actions
- (void)settings:(id)sender {
    SettingsViewController *view = [[SettingsViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [nav.navigationBar setTranslucent:NO];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

- (void)menu:(id)sender {
    
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

- (void)loadNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(settings:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(menu:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
}

- (void)loadPhotos {
    self.photos = [[NSArray alloc] initWithObjects:
                   @"profile",
                   @"IMG_3237.jpg",
                   @"IMG_3285.jpg",
                   @"IMG_3368.jpg",
                   @"IMG_3401.jpg",
                   @"IMG_3408.jpg",
                   @"IMG_3459.jpg",
                   @"IMG_3461.jpg",
                   @"IMG_3491.jpg",
                   @"IMG_3502.jpg", nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentDetailTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissDetailTransition alloc] init];
}

#pragma mark - Networking

//- (void)refresh {
//    [self makeFeedRequest];
//}
//
//- (void)makeFeedRequest {
//    NSLog(@"Refreshing");
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSString *urlString = @"http://www.gabemdev.com";
//    NSURL *url = [[NSURL alloc] initWithString:urlString];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSLog(@"Response: %@", response);
//        
//        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
////        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collectionView reloadData];
//            [_refreshControl endRefreshing];
//        });
//    }];
//    [task resume];
//}


@end
