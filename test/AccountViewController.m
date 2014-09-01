//
//  AccountViewController.m
//  Hipster
//
//  Created by Rockstar. on 8/16/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "AccountViewController.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "UIFont+HipsteriOSAdditions.h"
#import "GMWebViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>
#import "AccountView.h"

@interface AccountViewController () <UIViewControllerTransitioningDelegate>
- (void)_wwwOpen:(id)sender;
- (void)camera:(id)sender;
- (void)library:(id)sender;

@property (nonatomic, strong) NSArray *menu;
@property (nonatomic) AccountView *accountView;
@end

@implementation AccountViewController
@synthesize editProfile = _editProfile;
@synthesize www = _www;
@synthesize collection = _collection;

- (instancetype)init {
    if ((self = [super init])) {
        self.title = @"Profile";
//        _table.frame = CGRectMake(0.0f, 300.0f, 320.0f, 32.0f);
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    }
    self.contacts = [[NSMutableArray alloc] init];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor hipsterStaticColor];
    self.menu = [[NSArray alloc] initWithObjects:
                 @"Menu 1",
                 @"Menu 2",
                 @"Menu 3",
                 @"",
                 @"",
                 @"",
                 @"",
                 @"",
                 @"",
                 @"",
                 @"",
                 @"",
                 nil];
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    scroll.contentSize = CGSizeMake(320.0f, 650.0f);
    scroll.backgroundColor = [UIColor clearColor];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = YES;
    scroll.scrollEnabled = YES;
    [self.view addSubview:scroll];
    
    self.accountView = [[AccountView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];

    [scroll addSubview:self.accountView];
    
    //Collection View
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    [self.collection setCollectionViewLayout:layout];
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 255.0f, 320.0f, 318.0f) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor hipsterLightGrayColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    _collection.pagingEnabled = YES;
    [_collection reloadData];
    
    [scroll addSubview:_collection];
    
    //Website
    _www = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 170.0f, 310.0f, 32.0f)];
    [_www setTitleColor:[UIColor hipsterBlueColor] forState:UIControlStateNormal];
    [_www setTitleColor:[UIColor hipsterTextColor] forState:UIControlStateHighlighted];
    [_www addTarget:self action:@selector(_wwwOpen:) forControlEvents:UIControlEventTouchUpInside];
    _www.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
    [_www setTitle:@"www.gabemdev.com" forState:UIControlStateNormal];
    _www.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _www.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [scroll addSubview:_www];

    //Edit Profile Button
    _editProfile = [[UIButton alloc] initWithFrame:CGRectMake(110.0f, 65.0f, 200.0f, 32.0f)];
    [_editProfile setTitleColor:[UIColor hipsterBlueColor] forState:UIControlStateNormal];
    [_editProfile setTitleColor:[UIColor hipsterLightTextColor] forState:UIControlStateHighlighted];
    [_editProfile setBackgroundColor:[UIColor hipsterLightGrayColor]];
    _editProfile.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
    _editProfile.layer.cornerRadius = 3;
    [_editProfile setTitle:@"Edit Your Profile" forState:UIControlStateNormal];
    [scroll addSubview:_editProfile];
    
    //Button Bar View
    UIImageView *topBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 210.0f, 320.0f, 2.0f)];
    topBar.backgroundColor = [UIColor hipsterLightGrayColor];
    topBar.clipsToBounds = YES;
    topBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [scroll addSubview:topBar];
    
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 252.0f, 320.0f, 2.0f)];
    bottomBar.backgroundColor = [UIColor hipsterLightGrayColor];
    bottomBar.clipsToBounds = YES;
    bottomBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [scroll addSubview:bottomBar];
    
    UIImageView *middleBar = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2), 220.0f, 2.0f, 22.0f)];
    middleBar.backgroundColor = [UIColor hipsterLightGrayColor];
    middleBar.clipsToBounds = YES;
    middleBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [scroll addSubview:middleBar];
    
    UIImageView *leftBar = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4), 220.0f, 2.0f, 22.0f)];
    leftBar.backgroundColor = [UIColor hipsterLightGrayColor];
    leftBar.clipsToBounds = YES;
    leftBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [scroll addSubview:leftBar];
    
    UIImageView *rightBar = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80.0f), 220.0f, 2.0f, 22.0f)];
    rightBar.backgroundColor = [UIColor hipsterLightGrayColor];
    rightBar.clipsToBounds = YES;
    rightBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [scroll addSubview:rightBar];
    
    //Bottom View
    UIImageView *bottomViewBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 575.0f, 320.0f, 2.0f)];
    bottomViewBar.backgroundColor = [UIColor hipsterLightGrayColor];
    bottomViewBar.clipsToBounds = YES;
    bottomViewBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [scroll addSubview:bottomViewBar];
    
    //Bar Buttons
    /*_______________________
     Frame: 320.0f
     Separation: 80.0f (Frame / 4)
     Formula: Separation - First Image Witdh (44.0f) / 2
     First Positon:  ((Separation - Image Witdh) / 2)                     ((80.0f - 44.0f) / 2)          =  18.0f;
     Secont Positon: (((Separation * 2) - Image Witdh) - First Position) (((80.0f * 2) - 44.0f) - 18.0f) =  98.0f;
     Third Position: (((Separation * 3) - Image Witdh) - First Position) (((80.0f * 3) - 48.0f) - 18.0f) = 174.0f;
     Fourth Position:(((Separation * 4) - Image Witdh) - First Position) (((80.0f * 4) - 48.0f) - 18.0f) = 254.0f;
     ________________________
     */
    UIButton *messages = [[UIButton alloc] initWithFrame:CGRectMake(18.0f, 210.0f, 44.0f, 44.0f)];
    [messages setImage:[UIImage imageNamed:@"more-icon-notification"] forState:UIControlStateNormal];
    [scroll addSubview:messages];
    
    UIButton *contacts = [[UIButton alloc] initWithFrame:CGRectMake(98.0f, 210.0f, 44.0f, 44.0f)];
    [contacts setImage:[UIImage imageNamed:@"more-icon-invite"] forState:UIControlStateNormal];
    [scroll addSubview:contacts];
    
    UIButton *camera = [[UIButton alloc] initWithFrame:CGRectMake(178.0f, 212.0f, 48.0f, 40.0f)];
    [camera setImage:[UIImage imageNamed:@"more-addtofancy-camera-active"] forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(camera:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:camera];
    
    UIButton *photos = [[UIButton alloc] initWithFrame:CGRectMake(254.0f, 207.0f, 48.0f, 48.0f)];
    [photos setImage:[UIImage imageNamed:@"more-addtofancy-photos-active"] forState:UIControlStateNormal];
    [photos addTarget:self action:@selector(library:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:photos];
    
    //Social
    UIButton *fb = [[UIButton alloc] initWithFrame:CGRectMake(145.0f, 20.0f, 40.0f, 40.0f)];
    [fb setImage:[UIImage imageNamed:@"facebook_ios7"] forState:UIControlStateNormal];
    [scroll addSubview:fb];
    
    UIButton *tw = [[UIButton alloc] initWithFrame:CGRectMake(190.0f, 20.0f, 40.0f, 40.0f)];
    [tw setImage:[UIImage imageNamed:@"twitter_ios7"] forState:UIControlStateNormal];
    [scroll addSubview:tw];
    
    UIButton *go = [[UIButton alloc] initWithFrame:CGRectMake(235.0f, 20.0f, 40.0f, 40.0f)];
    [go setImage:[UIImage imageNamed:@"google_ios7"] forState:UIControlStateNormal];
    [scroll addSubview:go];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

#pragma mark - Actions
- (void)_wwwOpen:(id)sender {
    if (!_www.titleLabel.text.length > 5) {
        _www.titleLabel.text = @"web";
        return;
    }
    else {
        NSString *urlString = [NSString stringWithFormat:@"http://%@", _www.titleLabel.text];
        NSURL *url = [NSURL URLWithString:urlString];
    //    [[UIApplication sharedApplication] openURL:url];
        
        GMWebViewController *viewController = [[GMWebViewController alloc] init];
        [viewController loadURL:url];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)share:(id)sender {
    
}

- (void)camera:(id)sender {
    self.contactRelation = [[PFUser currentUser] objectForKey:@"contactRelations"];
    PFQuery *query = [self.contactRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
        else {
            self.contacts = objects;
            [self.collection reloadData];
        }
    }];
    
    if (self.image == nil) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        self.imagePicker.modalPresentationStyle = UIModalPresentationFormSheet;
        self.imagePicker.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage, nil];
        
        [self presentViewController:self.imagePicker animated:NO completion:nil];
        
    }
}

- (void)library:(id)sender {
    self.contactRelation = [[PFUser currentUser] objectForKey:@"contactRelations"];
    PFQuery *query = [self.contactRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
        else {
            self.contacts = objects;
            [self.collection reloadData];
        }
    }];
    
    if (self.image == nil) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        self.imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage, nil];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.menu count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor hipsterBlueColor];
    UIImageView *photoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-who-to-follow"]];
    photoImageView.frame = CGRectMake(53.0f, 53.0f, 50.0f, 50.0f);
    [cell addSubview:photoImageView];
    
    return cell;
}

#pragma mark - Image Picker Controller Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaTye = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaTye isEqualToString:(NSString *)kUTTypeImage]) {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage*)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height {
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
    
    
}

@end
