//
//  ExplorViewController.m
//  oye2
//
//  Created by Lee on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ExplorViewController.h"

static const int HEAD_BTN_H = 24;
static const int HEAD_BTN_W = 52;
static const int HEAD_BTN_PADDING_TOP = 29;

@interface ExplorViewController (){
    UIView *head;
    UIButton *pathBtn;
    UIButton *userBtn;
    UIView *catbar;
    
}

@end

@implementation ExplorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createHead
{
    if (!head) {
        head = [[UIView alloc] init];
    }
    head.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEAD_H);
    [self.view addSubview:head];
}

- (void)createPathAndUserBtn
{
    pathBtn = [[UIButton alloc] init];
    float pathBtnX = (SCREEN_WIDTH - HEAD_BTN_W) / 2;
    pathBtn.frame = CGRectMake(pathBtnX, HEAD_BTN_PADDING_TOP, HEAD_BTN_W, HEAD_BTN_H);
    [pathBtn setImage:[UIImage imageNamed:@"pathBtnBgSelected.png"] forState:UIControlStateNormal];
    [self.view addSubview:pathBtn];
    
    userBtn = [[UIButton alloc] init];
    float userBtnX = (SCREEN_WIDTH - HEAD_BTN_W) / 2 + HEAD_BTN_W;
    userBtn.frame = CGRectMake(userBtnX, HEAD_BTN_PADDING_TOP, HEAD_BTN_W, HEAD_BTN_H);
    [userBtn setImage:[UIImage imageNamed:@"userBtnBgNormal.png"] forState:UIControlStateNormal];
    [self.view addSubview:userBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
