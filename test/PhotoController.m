//
//  PhotoController.m
//  Hipster
//
//  Created by Rockstar. on 8/31/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "PhotoController.h"
#import "FeedViewController.h"
#import "FeedCell.h"

@implementation PhotoController

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void (^)(UIImage *))completion {
    if (photo == nil || size == nil || completion == nil) {
        return;
    }
    
}

+ (void)avatarForPhoto:(NSDictionary *)photo completion:(void (^)(UIImage *))completion {
    if (photo == nil || completion == nil) {
        return;
    }
}

@end
