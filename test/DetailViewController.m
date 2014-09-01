//
//  DetailViewController.m
//  Hipster
//
//  Created by Rockstar. on 8/31/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailedView.h"
#import "PhotoController.h"

@interface DetailViewController ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) DetailedView *detailView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.95];
    self.view.clipsToBounds = YES;
    
    self.detailView = [[DetailedView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 400.0f)];
    self.detailView.alpha = 0.0f;
    [self.view addSubview:self.detailView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -320.0f, 320.f, 320.0f)];
    self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    [self.view addSubview:self.imageView];
    
    
    [PhotoController imageForPhoto:self.photo size:nil completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:swipe];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGPoint point = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:point];
    [self.animator addBehavior:snap];
    
    self.detailView.center = point;
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:kNilOptions animations:^{
        self.detailView.alpha = 1.0f;
    } completion:nil];
}

- (void)close {
    [self.animator removeAllBehaviors];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
    [self.animator addBehavior:snap];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
