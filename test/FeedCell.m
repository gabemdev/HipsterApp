//
//  FeedCell.m
//  Hipster
//
//  Created by Rockstar. on 8/15/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "FeedCell.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "UIFont+HipsteriOSAdditions.h"
#import <Parse/Parse.h>

@interface FeedCell ()
@property (nonatomic) UIButton *userName;
@property (nonatomic) UILabel *title;
@property (nonatomic) UIImageView *backgroundImage;
@property (nonatomic) UIImageView *avatar;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIImageView *backView;

@end

@implementation FeedCell

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
//        [self addSubview:self.title];
        [self addSubview:self.backView];
        [self addSubview:self.backgroundImage];
        [self addSubview:self.cellImage];
        [self addSubview:self.userName];
        [self addSubview:self.avatar];
        [self addSubview:self.userName];
        [self addSubview:self.likesButton];
        
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.imageView.frame = CGRectMake(0.0f, 0.0f, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 20.0f);
//    self.title.frame = CGRectMake(0.0f, self.contentView.bounds.size.height - 20.0f, self.contentView.bounds.size.width/2, 20.0f);
//}


#pragma mark - UIControls
- (UIImageView *)cellImage {
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 28.0f)];
        _cellImage.layer.cornerRadius = 1.0f;
        _cellImage.contentMode = UIViewContentModeScaleToFill;
    }
    return _cellImage;
}


- (UIImageView *)backgroundImage {
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 28.0f)];
        _backgroundImage.backgroundColor = [UIColor hipsterBlueColor];
        _backgroundImage.layer.cornerRadius = 1;
        _backgroundImage.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImage;
}

- (UIImageView *)avatar {
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, self.contentView.bounds.size.height - 26.0f, 24.0f, 24.0f)];
        _avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
        _avatar.layer.borderColor = [UIColor colorWithRed:0.59f green:0.62f blue:0.67f alpha:1.0f].CGColor;
        _avatar.layer.borderWidth = 2.0f;
        _avatar.layer.masksToBounds = YES;
        _avatar.backgroundColor = [UIColor hipsterLightGrayColor];
        _avatar.userInteractionEnabled = NO;
        [_avatar setImage:[UIImage imageNamed:@"more-icon-groupgift"]];
    }
    return _avatar;
}

- (UIButton *)userName {
    if (!_userName) {
        _userName = [[UIButton alloc] initWithFrame:CGRectMake(32.0f, self.contentView.bounds.size.height - 30.0f, 200.0f, 32.0f)];
        _userName.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
        _userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIColor *textColor = [UIColor hipsterLightTextColor];
        [_userName setTitleColor:textColor forState:UIControlStateNormal];
        [_userName setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_userName addTarget:self action:@selector(openUser:) forControlEvents:UIControlEventTouchUpInside];
        
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            NSString *username = [NSString stringWithFormat:@"%@ %@", [currentUser objectForKey:@"first"], [currentUser objectForKey:@"last"]];
            [_userName setTitle:username forState:UIControlStateNormal];
        }
        else {
            [_userName setTitle:@"username" forState:UIControlStateNormal];
        }
    }
    return _userName;
}

- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width - 50.0f, self.contentView.bounds.size.height - 33.0f, 50.0f, 40.0f)];
        _likesButton.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
        [_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likesButton.adjustsImageWhenHighlighted = NO;
        _likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
        UIColor *textColor = [UIColor hipsterLightTextColor];
        [_likesButton setTitleColor:textColor forState:UIControlStateNormal];
        [_likesButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_likesButton addTarget:self action:@selector(likePhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        NSNumber *likesMNumber = [NSNumber numberWithInt:300];
        NSString *likes = [likesMNumber stringValue];
        [_likesButton setTitle:likes forState:UIControlStateNormal];
        [_likesButton setContentMode:UIViewContentModeCenter];
        
    }
    return _likesButton;
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 3.0f;
        _backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
        _backView.layer.masksToBounds = NO;
        _backView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _backView.layer.shadowOpacity = 0.75;
        _backView.layer.shadowRadius = 3.0f;
        _backView.layer.shouldRasterize = YES;
    }
    return _backView;
}

#pragma mark - Actions
- (void)openUser:(id)sender {
    
}

- (void)likePhoto:(id)sender {
    
}

@end
