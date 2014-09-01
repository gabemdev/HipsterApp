//
//  AccountViewController.h
//  Hipster
//
//  Created by Rockstar. on 8/16/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AccountViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//User Info
@property (nonatomic, strong) UIButton *www;
@property (nonatomic, strong) UIButton *editProfile;

//UICollection
@property (nonatomic, strong) UICollectionView *collection;

//UIImagePicker
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *videoFilePath;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) PFRelation *contactRelation;
@property (nonatomic, strong) NSMutableArray *recepients;

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;


@end
