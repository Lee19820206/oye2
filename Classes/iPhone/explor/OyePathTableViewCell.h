//
//  OyePathTableViewCell.h
//  oye2
//
//  Created by Lee on 15/7/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(int, PathType) {
    PathTypeWaitting    = 0,
    PathTypeFinished    = 1,
    PathTypeInvest      = 2,
    PathTypeJoin        = 3,
};
@interface OyePathTableViewCell : UITableViewCell

@property(nonatomic)int typa;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) UIImage *imgLeft;
@property(strong, nonatomic) UIImage *imgRight;

- (void)initWithType:(PathType)typa andImageLeft:(UIImage *)imgLeft andImageRight:(UIImage *)imgRight andInfo:(NSString *)information;

- (void)clean;
@end
