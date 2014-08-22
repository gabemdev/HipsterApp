//
//  FeedViewController.h
//  Hipster
//
//  Created by Rockstar. on 8/14/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface FeedViewController : UICollectionViewController
@property (nonatomic) PFObject *selectedMessage;


- (void)settings:(id)sender;
- (void)menu:(id)sender;

@end
