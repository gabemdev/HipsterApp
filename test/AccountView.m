//
//  AccountView.m
//  Hipster
//
//  Created by Rockstar. on 8/24/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "AccountView.h"
#import "UIColor+HipsteriOSAdditions.h"
#import "UIFont+HipsteriOSAdditions.h"
#import "GMWebViewController.h"
#import <Parse/Parse.h>

@interface AccountView () <UIViewControllerTransitioningDelegate>
@property (nonatomic) UIImageView *profile;
@property (nonatomic) UILabel *user;
@property (nonatomic) UILabel *userInfo;
@property (nonatomic) UIButton *www;
@property (nonatomic) UIButton *editProfile;
@end

@implementation AccountView

#pragma mark - UIView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.user];
        [self addSubview:self.profile];
        [self addSubview:self.userInfo];
        [self addSubview:self.www];
        [self addSubview:self.editProfile];
    }
    return self;
}


#pragma mark - UIControls

- (UIImageView *)profile {
    if (!_profile) {
        _profile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile"]];
        [_profile setFrame:CGRectMake(10.0f, 10.0f, 80.0f, 80.0f)];
        _profile.layer.cornerRadius = _profile.frame.size.width/2;
        _profile.clipsToBounds = YES;
        _profile.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return _profile;
}

- (UILabel *)user {
    if (!_user) {
        PFUser *currentUser = [PFUser currentUser];
        _user = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 90.0f, 140.0f, 32.0f)];
        _user.font = [UIFont boldHipsterInterfaceFontOfSize:14.0f];
        _user.textColor = [UIColor hipsterTextColor];
        _user.textAlignment = NSTextAlignmentLeft;
        _user.text = [NSString stringWithFormat:@"%@ %@", [currentUser objectForKey:@"first"], [currentUser objectForKey:@"last"]];
        if ([currentUser objectForKey:@"first"] == NULL && [currentUser objectForKey:@"last"] ==  NULL) {
            _user.text = currentUser.username;
        }
    }
    return _user;
}

- (UILabel *)userInfo {
    if (!_userInfo) {
        _userInfo = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 105.0f, 310.0f, 80.0f)];
        _userInfo.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
        _userInfo.textColor = [UIColor hipsterTextColor];
        _userInfo.textAlignment = NSTextAlignmentLeft;
        _userInfo.numberOfLines = 3;
        [_userInfo setText:@"iOS Dev, Tech junkie, Mac Lover, 9-5 Robot, Daddy, Hubby, Taco Lover & Blogger wannabe by night!"];
    }
    return _userInfo;
}

- (UIButton *)editProfile {
    if (!_editProfile) {
        _editProfile = [[UIButton alloc] initWithFrame:CGRectMake(110.0f, 65.0f, 200.0f, 32.0f)];
        [_editProfile setTitleColor:[UIColor hipsterBlueColor] forState:UIControlStateNormal];
        [_editProfile setTitleColor:[UIColor hipsterLightTextColor] forState:UIControlStateHighlighted];
        [_editProfile setBackgroundColor:[UIColor hipsterLightGrayColor]];
        _editProfile.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:14.0f];
        _editProfile.layer.cornerRadius = 3;
        [_editProfile setTitle:@"Edit Your Profile" forState:UIControlStateNormal];
    }
    
    return _editProfile;
}

@end
