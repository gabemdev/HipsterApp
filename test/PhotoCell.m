//
//  PhotoCell.m
//  Hipster
//
//  Created by Rockstar. on 8/19/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "PhotoCell.h"
#import "AccountViewController.h"

@implementation PhotoCell

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
