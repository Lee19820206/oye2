//
//  CustomTabBar.m
//  oye2
//
//  Created by Lee on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar() {
    UIImage *normalStateBgImage;
    UIImage *selectedStateBgImage;
    UIImageView *bgImageView;
//    UIImageView *tabBtn1;
//    UIImageView *tabBtn2;
//    UIImageView *tabBtn3;
//    UIImageView *tabBtn4;
//    UIImageView *tabBtn5;
}

@end

@implementation CustomTabBar
@synthesize delegate, tabBarTag;
- (instancetype)initWithNormalStateImage:(UIImage *)normalStateImg
                   andSelectedStateImage:(UIImage *)selectedImg
{
    if (self = [super init]) {
        normalStateBgImage = normalStateImg;
        selectedStateBgImage = selectedImg;
    }
    
    bgImageView = [[UIImageView alloc] initWithImage:normalStateBgImage];
    bgImageView.frame = CGRectMake(0, 0, 33, 40);
    [self addSubview:bgImageView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barTaped)];
    [self addGestureRecognizer:tapGesture];
    
    return self;
}

- (void)switchToSelectedState
{
    bgImageView.image = selectedStateBgImage;
}

- (void)switchToNormalState
{
    bgImageView.image = normalStateBgImage;
}

- (void)barTaped
{
    if (delegate && [delegate respondsToSelector:@selector(tabBarDidTapped:)]) {
        [delegate tabBarDidTapped:self];
    }
}



@end
