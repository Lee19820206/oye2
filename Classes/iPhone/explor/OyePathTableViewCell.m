//
//  OyePathTableViewCell.m
//  oye2
//
//  Created by Lee on 15/7/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "OyePathTableViewCell.h"
#import "WelcomeViewController.h"

static NSUInteger IMG_W = 159;
static NSUInteger IMG_H = 159;
static NSUInteger PATH_TABLE_OFFSET_TAG = 3000;
static NSUInteger KID_W = 24;
static NSUInteger KID_H = 24;

static NSUInteger ZAN_KID_W = 12;
static NSUInteger ZAN_KID_H = 11;
static NSUInteger GAP_ZAN = 55;
static NSUInteger ZAN_PADDING_TOP = 10;
static NSUInteger LABEL_W = 50;

@interface OyePathTableViewCell(){
    UIImageView *leftImgView;
    UIImageView *rightImgView;
    
    UIButton *leftBtn;
    UIButton *rightBtn;
    
    UIImageView *leftKid;
    UIImageView *rightKid;
    
    UIImageView *leftZanKid;
    UIImageView *rightZanKid;
    
    UILabel *leftLabel;
    UILabel *rightLabel;
}

@end

@implementation OyePathTableViewCell
@synthesize info;

- (void)awakeFromNib {
    // Initialization code
}

- (void)initWithType:(PathType)typa andImageLeft:(UIImage *)imgLeft andImageRight:(UIImage *)imgRight andInfo:(NSString *)information
{
    IMG_W = SCREEN_WIDTH / 2 - 1;
    IMG_H = IMG_W;
    
    NSArray *typas = @[@"dmsKid", @"tstKid", @"finishedKid", @"joinKid", @"playingKid"];
    
    if (leftImgView == nil) {
        leftImgView = [[UIImageView alloc] init];
        leftImgView.frame = CGRectMake(0, 1, IMG_W, IMG_H);
    }
    
    
    if (rightImgView == nil) {
        rightImgView = [[UIImageView alloc] init];
        rightImgView.frame = CGRectMake(SCREEN_WIDTH - IMG_W, 1, IMG_W, IMG_H);
    }
    
    if (leftBtn == nil) {
        leftBtn = [[UIButton alloc] init];
        leftBtn.frame = CGRectMake(0, 1, IMG_W, IMG_H);
        leftBtn.tag = PATH_TABLE_OFFSET_TAG + 1;
    }
    
    if (rightBtn == nil) {
        rightBtn = [[UIButton alloc] init];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH - IMG_W, 1 , IMG_W, IMG_H);
        rightBtn.tag = PATH_TABLE_OFFSET_TAG + 2;
    }
    
    if (leftKid == nil) {
        leftKid = [[UIImageView alloc] init];
        leftKid.frame = CGRectMake(IMG_W - KID_W, 1, KID_W, KID_H);
    }
    
    if (rightKid == nil) {
        rightKid = [[UIImageView alloc] init];
        rightKid.frame = CGRectMake(SCREEN_WIDTH - KID_W, 1, KID_W, KID_H);
    }
    
    if (leftZanKid == nil) {
        leftZanKid = [[UIImageView alloc] init];
        leftZanKid.frame = CGRectMake(GAP_ZAN, ZAN_PADDING_TOP, ZAN_KID_W, ZAN_KID_H);
    }
    
    if (rightZanKid == nil) {
        rightZanKid = [[UIImageView alloc] init];
        rightZanKid.frame = CGRectMake(SCREEN_WIDTH - IMG_W + GAP_ZAN, ZAN_PADDING_TOP, ZAN_KID_W, ZAN_KID_H);
    }
    
    leftLabel = [[UILabel alloc] init];
    leftLabel.frame = CGRectMake(0, ZAN_PADDING_TOP -1 , LABEL_W, 11);
    leftLabel.font = [UIFont boldSystemFontOfSize:11];
    leftLabel.textAlignment = NSTextAlignmentRight;
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.shadowColor = [UIColor grayColor];
    leftLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    leftLabel.text = @"1.8万";
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.frame = CGRectMake(SCREEN_WIDTH - IMG_W, ZAN_PADDING_TOP -1, LABEL_W, 11);
    rightLabel.font = [UIFont boldSystemFontOfSize:11];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.shadowColor = [UIColor grayColor];
    rightLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    rightLabel.text = @"2,678";
    
    
    leftZanKid.image = [UIImage imageNamed:@"zanKid.png"];
    rightZanKid.image = [UIImage imageNamed:@"zanKid.png"];
    
    NSString *lStr = [NSString stringWithFormat:@"%@.png", [typas objectAtIndex:(NSUInteger)(arc4random() % 5)]];
    NSString *rStr = [NSString stringWithFormat:@"%@.png", [typas objectAtIndex:(NSUInteger)(arc4random() % 5)]];
    
    leftKid.image = [UIImage imageNamed:lStr];
    rightKid.image = [UIImage imageNamed:rStr];
    
    [self addSubview:leftImgView];
    [self addSubview:rightImgView];
    
    [self addSubview:leftKid];
    [self addSubview:rightKid];
    
    [self addSubview:rightZanKid];
    [self addSubview:leftZanKid];
    
    [self addSubview:leftLabel];
    [self addSubview:rightLabel];
    
    [self addSubview:leftBtn];
    [self addSubview:rightBtn];
    
    [leftBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    leftImgView.image = imgLeft;
    rightImgView.image = imgRight;
    
    if (imgLeft == nil) {
        leftBtn.enabled = false;
    }
    
    if (imgRight == nil) {
        rightBtn.enabled = false;
    }
    self.info = information;
    
    NSArray *nameArray = @[@"我是天才", @"也许这是最后一次", @"直到世界的尽头", @"猴子请来的逗比",  @"来自火星的乌龟",  @"环法撞死狗",  @"一拳打爆一头牛",  @"风吹屁屁凉",  @"百撕不得骑姐",  @"城墙倒拐"];
    
    
    UIImageView * leftAvatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
    leftAvatar.frame = CGRectMake(30.f, IMG_H - 30.f, 22.f, 22.f);
    leftAvatar.layer.masksToBounds = YES;
    leftAvatar.layer.cornerRadius = 11.f;
    
    UILabel *leftNameLablel;
    UILabel *rightNameLabel;
    
    leftNameLablel = [[UILabel alloc] init];
    leftNameLablel.frame = CGRectMake(60.f, IMG_H - 30.f + 5.f, IMG_W - 60.f, 12.f);
    leftNameLablel.text =[NSString stringWithFormat:@"By %@", [nameArray objectAtIndex:(arc4random()%[nameArray count])]];// ;
    leftNameLablel.font = [UIFont systemFontOfSize:10.f];
    [leftImgView addSubview:leftNameLablel];
    
    rightNameLabel = [[UILabel alloc] init];
    rightNameLabel.frame = CGRectMake(60.f, IMG_H - 30.f + 5.f, IMG_W - 60.f, 12.f);
    rightNameLabel.text = [NSString stringWithFormat:@"By %@", [nameArray objectAtIndex:(arc4random()%[nameArray count])]];;
    rightNameLabel.font = [UIFont systemFontOfSize:10.f];
    [rightImgView addSubview:rightNameLabel];
    
    leftNameLablel.textColor = rightNameLabel.textColor = [UIColor whiteColor];
    
    UIImageView * rightAvatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
    rightAvatar.frame = CGRectMake(30.f, IMG_H - 30.f, 22.f, 22.f);
    rightAvatar.layer.masksToBounds = YES;
    rightAvatar.layer.cornerRadius = 11.f;
    
    [leftImgView addSubview:leftAvatar];
    
    [rightImgView addSubview:rightAvatar];
}

- (void)clean
{
    
}

- (void)pressBtn:(UIButton *)btn
{
    NSUInteger tag = btn.tag - PATH_TABLE_OFFSET_TAG;
    NSLog(@"path_table_btn_tag: %d", (int)tag);
    
    WelcomeViewController *vc = [[WelcomeViewController alloc] init];
    [SharedAppDelegate.oyeNavigationVc pushViewController:vc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImage *)getEllipseImageWithImage:(UIImage *)originImage
{
    CGFloat padding = 5;//圆形图像距离图像的边距
    UIColor *epsBackColor = [UIColor greenColor];//图像的背景色
    CGSize originsize = originImage.size;
    CGRect originRect = CGRectMake(0, 0, originsize.width, originsize.height);
    
    UIGraphicsBeginImageContext(originsize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //目标区域。
    CGRect desRect =  CGRectMake(padding, padding,originsize.width-(padding*2), originsize.height-(padding*2));
    
    //设置填充背景色。
    CGContextSetFillColorWithColor(ctx, epsBackColor.CGColor);
    UIRectFill(originRect);//真正的填充
    
    //设置椭圆变形区域。
    CGContextAddEllipseInRect(ctx,desRect);
    CGContextClip(ctx);//截取椭圆区域。
    
    [originImage drawInRect:originRect];//将图像画在目标区域。
    
    // 边框 //
    CGFloat borderWidth = 10;
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);//设置边框颜色
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetLineWidth(ctx, borderWidth);//设置边框宽度。
    CGContextAddEllipseInRect(ctx, desRect);//在这个框中画圆
    CGContextStrokePath(ctx); // 描边框。
    // 边框 //
    
    UIImage* desImage = UIGraphicsGetImageFromCurrentImageContext();// 获取当前图形上下文中的图像。
    UIGraphicsEndImageContext();
    return desImage;
}



@end
