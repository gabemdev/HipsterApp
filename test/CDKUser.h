//
//  CDKUser.h
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//


extern NSString *const kCDKCurrentUserChangedNotificationName;

@interface CDKUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *hasPlus;
@property (nonatomic, strong) NSSet *tasks;
@property (nonatomic, strong) NSSet *lists;
@property (nonatomic, strong) NSString *accessToken;

+ (CDKUser *)currentUser;
+ (void)setCurrentUser:(CDKUser *)user;
@end

