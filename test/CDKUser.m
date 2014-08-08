//
//  CDKUser.m
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "CDKUser.h"


static CDKUser *__currentUser = nil;
static NSString *const kCDKUserIDKey = @"CDKUserID";
@implementation CDKUser

@dynamic firstName;
@dynamic lastName;
@dynamic username;
@dynamic email;
@dynamic tasks;
@dynamic lists;
@dynamic hasPlus;
@synthesize accessToken = _accessToken;

+ (NSString *)entityName {
	return @"User";
}

+ (CDKUser *)currentUser {
	if (!__currentUser) {
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		NSNumber *userID = [userDefaults objectForKey:kCDKUserIDKey];
		if (!userID) {
			return nil;
		}
        
	}
	return __currentUser;
}

+ (void)setCurrentUser:(CDKUser *)user {
	if (__currentUser) {
	}
    
//	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//	if (!user.remoteID || !user.accessToken) {
//		__currentUser = nil;
//		[userDefaults removeObjectForKey:kCDKUserIDKey];
//	} else {
//		NSError *error = nil;
//		[SSKeychain setPassword:user.accessToken forService:kCDKKeychainServiceName account:user.remoteID.description error:&error];
//		if (error) {
//			NSLog(@"[CheddarKit] Failed to save access token: %@", error);
//		}
//		
//		__currentUser = user;
//		[userDefaults setObject:user.remoteID forKey:kCDKUserIDKey];
//	}
//	
//	[userDefaults synchronize];
//	[[NSNotificationCenter defaultCenter] postNotificationName:kCDKCurrentUserChangedNotificationName object:user];
}



@end
