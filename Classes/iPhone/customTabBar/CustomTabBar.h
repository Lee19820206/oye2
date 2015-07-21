//
//  CustomTabBar.h
//  oye2
//
//  Created by Lee on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Oye2CusTabBarDelegate<NSObject>
@optional
- (void)tabBarDidTapped:(id)sender;
@end

@interface CustomTabBar : UIView {

}


@property(nonatomic)int tabBarTag;
@property(weak, nonatomic)id delegate;
- (instancetype)initWithNormalStateImage:(UIImage *)normalStateImg andSelectedStateImage:(UIImage *)selectedImg;
- (void)setBgWidth:(float)width andHeight:(float)height;

- (void)switchToSelectedState;
- (void)switchToNormalState;

@end
