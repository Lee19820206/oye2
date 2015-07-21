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
static const int BTN_TAB_OFFSET = 1000;
static const int CAT_BAR_H = 34;

@interface ExplorViewController (){
    UIView *head;
    CustomTabBar *pathBtn;
    CustomTabBar *userBtn;
    UIView *catbar;
    int currentTag;
    UIView *contentView;
    UIView *pathView;
    UIView *userView;
    UILabel *catLabelState;
    UILabel *catLabelSort;
}

@end

@implementation ExplorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createHead];
    [self createPathAndUserBtn];
    [self createContentView];
    [self createPathView];
    // Do any additional setup after loading the view.
}

#pragma mark - create UI
//创建顶部背景
- (void)createHead
{
    if (!head) {
        head = [[UIView alloc] init];
    }
    head.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEAD_H);
    head.backgroundColor = RGBCOLOR(236, 236, 0xec);
    [self.view addSubview:head];
}

//创建路线和用户按钮
- (void)createPathAndUserBtn
{
    pathBtn = [[CustomTabBar alloc]
               initWithNormalStateImage:[UIImage imageNamed:@"pathBtnBgNormal.png"]
               andSelectedStateImage:[UIImage imageNamed:@"pathBtnBgSelected.png"]];
    float pathBtnX = (SCREEN_WIDTH - HEAD_BTN_W * 2) / 2;
    pathBtn.frame = CGRectMake(pathBtnX, HEAD_BTN_PADDING_TOP, HEAD_BTN_W, HEAD_BTN_H);
    [pathBtn setBgWidth:HEAD_BTN_W andHeight:HEAD_BTN_H];
    pathBtn.tabBarTag = BTN_TAB_OFFSET + 1;;
    pathBtn.delegate = self;
    [pathBtn switchToSelectedState];
    currentTag = pathBtn.tabBarTag;
    [self.view addSubview:pathBtn];
    
    userBtn = [[CustomTabBar alloc]
               initWithNormalStateImage:[UIImage imageNamed:@"userBtnBgNormal.png"]
               andSelectedStateImage:[UIImage imageNamed:@"userBtnBgSelected.png"]];
    userBtn.tabBarTag = BTN_TAB_OFFSET + 2;
    float userBtnX = (SCREEN_WIDTH - HEAD_BTN_W * 2) / 2 + HEAD_BTN_W;
    userBtn.frame = CGRectMake(userBtnX, HEAD_BTN_PADDING_TOP, HEAD_BTN_W, HEAD_BTN_H);
    [userBtn setBgWidth:HEAD_BTN_W andHeight:HEAD_BTN_H];
    userBtn.delegate = self;
    [self.view addSubview:userBtn];
}

- (void)createContentView
{
    contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, HEAD_H, SCREEN_WIDTH, SCREEN_HEIGHT - HEAD_H - TABBAR_H);
    contentView.backgroundColor = RGBCOLOR(0xf3, 0xf6, 0xf9);
    [self.view addSubview:contentView];
    
}

- (void)createPathView
{
    pathView = [[UIView alloc] init];
    pathView.frame = CGRectMake(0, HEAD_H, SCREEN_WIDTH, SCREEN_HEIGHT - HEAD_H - TABBAR_H);
    pathView.backgroundColor = RGBCOLOR(0xf3, 0xf6, 0xf9);
    [self.view addSubview:pathView];
    
    catbar = [[UIView alloc] init];
    catbar.backgroundColor = RGBCOLOR(0xf5, 0xf5, 0xf6);
    catbar.frame = CGRectMake(0, 0, SCREEN_WIDTH, CAT_BAR_H);
    catbar.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    catbar.layer.borderWidth = 0.5;
    [pathView addSubview:catbar];
    
    
    float labelWidth = 56.0;
    float labelHeight = 14;
    catLabelState = [[UILabel alloc] init];
    catLabelState.frame = CGRectMake((SCREEN_WIDTH / 2 - labelWidth) / 2, (CAT_BAR_H - labelHeight)/2, labelWidth, labelHeight);
    catLabelState.text = @"全部状态";
    catLabelState.font = [UIFont boldSystemFontOfSize:14];
    catLabelState.textColor = RGBCOLOR(0x75, 0x75, 0x75);
    [catbar addSubview:catLabelState];
    
    catLabelSort = [[UILabel alloc] init];
    catLabelSort.frame = CGRectMake(SCREEN_WIDTH / 2 + (SCREEN_WIDTH / 2 - labelWidth) / 2, (CAT_BAR_H - labelHeight)/2, labelWidth, labelHeight);
    catLabelSort.text = @"默认排序";
    catLabelSort.font = [UIFont boldSystemFontOfSize:14];
    catLabelSort.textColor = RGBCOLOR(0x75, 0x75, 0x75);
    [catbar addSubview:catLabelSort];
}

- (void)createUserView
{
    
}

#pragma mark - CustabBar tap delegate Oye2CusTabBarDelegate
- (void)tabBarDidTapped:(id)sender{
    NSLog(@"tap userandpathbtn!!");
    CustomTabBar *btn = (CustomTabBar *)sender;
    NSLog(@"btnTag%d", btn.tabBarTag);
    if (currentTag == btn.tabBarTag) {
        return;
    }else{
        currentTag = btn.tabBarTag;
    }
    int tag = btn.tabBarTag - BTN_TAB_OFFSET;
    if (tag == 1) {
        [pathBtn switchToSelectedState];
        [userBtn switchToNormalState];
        [self showPath];
    } else if (tag == 2){
        [userBtn switchToSelectedState];
        [pathBtn switchToNormalState];
        [self showUser];
    }
}

#pragma mark - show Path OR User View
- (void)showPath
{
    NSLog(@"show path vc!!");
}

- (void)showUser
{
    NSLog(@"show user vc!!");
}


//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
