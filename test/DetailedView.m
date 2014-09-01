//
//  DetailedView.m
//  Hipster
//
//  Created by Rockstar. on 8/31/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "DetailedView.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "PhotoController.h"
#import <Parse/Parse.h>

@interface DetailedView ()
@property (nonatomic) UIImageView *avatar;
@property (nonatomic) UIButton *username;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *comments;
@end

@implementation DetailedView

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
//    PFUser *currentUser = [PFUser currentUser];
//    if (currentUser) {
//        
//        NSString *username = [NSString stringWithFormat:@"%@ %@", [currentUser objectForKey:@"first"], [currentUser objectForKey:@"last"]];
//        [_username setTitle:username forState:UIControlStateNormal];
    
//        NSNumber *likesMNumber = [NSNumber numberWithInt:300];
//        NSString *likes = [likesMNumber stringValue];
//        [_likesButton setTitle:likes forState:UIControlStateNormal];
//        [_likesButton setContentMode:UIViewContentModeCenter];
    
//        NSNumber *commentsNumber = [NSNumber numberWithInt:40];
//        NSString *comment = [commentsNumber stringValue];
//        [_comments setTitle:comment forState:UIControlStateNormal];
//    }
//    else {
//        [_username setTitle:@"username" forState:UIControlStateNormal];
//        [_likesButton setTitle:@"0" forState:UIControlStateNormal];
//        [_comments setTitle:@"0" forState:UIControlStateNormal];
//    }

}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.avatar];
        [self addSubview:self.username];
        [self addSubview:self.likesButton];
        [self addSubview:self.comments];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(320.0f, 400.0f);
}

#pragma mark - UIControls
- (UIImageView *)avatar {
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 32.0f, 32.0f)];
        _avatar.layer.cornerRadius = 16.0f;
        _avatar.layer.borderColor = [UIColor hipsterLightGrayColor].CGColor;
        _avatar.layer.borderWidth = 1.0f;
        _avatar.layer.masksToBounds = YES;
        _avatar.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        _avatar.userInteractionEnabled = NO;
    }
    return _avatar;
}

- (UIButton *)username {
    if (!_username) {
        _username = [[UIButton alloc] initWithFrame:CGRectMake(47.0f, 0.0f, 200.0f, 32.0f)];
        _username.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _username.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIColor *textColor = [UIColor hipsterBlueColor];
        [_username setTitleColor:textColor forState:UIControlStateNormal];
        [_username setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_username addTarget:self action:@selector(openUser:) forControlEvents:UIControlEventTouchUpInside];
        
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            
            NSString *username = [NSString stringWithFormat:@"%@ %@", [currentUser objectForKey:@"first"], [currentUser objectForKey:@"last"]];
            [_username setTitle:username forState:UIControlStateNormal];
        }
        else {
            [_username setTitle:@"username" forState:UIControlStateNormal];
        }
    }
    return _username;
}

- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 360.0f, 50.0f, 40.0f)];
        _likesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likesButton.adjustsImageWhenHighlighted = NO;
        _likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
        UIColor *textColor = [UIColor hipsterBlueColor];
        [_likesButton setTitleColor:textColor forState:UIControlStateNormal];
        [_likesButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_likesButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            NSNumber *likesMNumber = [NSNumber numberWithInt:300];
            NSString *likes = [likesMNumber stringValue];
            [_likesButton setTitle:likes forState:UIControlStateNormal];
            [_likesButton setContentMode:UIViewContentModeCenter];
        }
        else {
            [_likesButton setTitle:@"0" forState:UIControlStateNormal];
        }
    }
    return _likesButton;
}

- (UIButton *)comments {
    if (!_comments) {
        _comments = [[UIButton alloc] initWithFrame:CGRectMake(260.f, 360.0f, 50.0f, 40.0f)];
        _comments.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_comments setImage:[UIImage imageNamed:@"timeline-comment"] forState:UIControlStateNormal];
        _comments.adjustsImageWhenHighlighted = NO;
        _comments.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _comments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        UIColor *textColor = [UIColor hipsterBlueColor];
        [_comments setTitleColor:textColor forState:UIControlStateNormal];
        [_comments setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_comments addTarget:self action:@selector(openComments:) forControlEvents:UIControlEventTouchUpInside];
        
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            NSNumber *commentsNumber = [NSNumber numberWithInt:40];
            NSString *comment = [commentsNumber stringValue];
            [_comments setTitle:comment forState:UIControlStateNormal];
        }
        else {
            [_comments setTitle:@"0" forState:UIControlStateNormal];
        }
    }
    return _comments;
}

#pragma mark - Actions
- (void)openUser:(id)sender {
    
}

- (void)openPhoto:(id)sender {
    
}

- (void)openComments:(id)sender {
    
}

@end
