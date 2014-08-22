//
//  FeedCell.m
//  Hipster
//
//  Created by Rockstar. on 8/15/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "FeedCell.h"
#import "UIColor+HipsteriOSAdditions.h"

@implementation FeedCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
//        self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        self.imageView.backgroundColor = [UIColor hipsterBlueColor];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

@end
