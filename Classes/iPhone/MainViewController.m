//
//  MainViewController.m
//  oye2
//
//  Created by Lee on 15-6-10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MainViewController.h"
#import "GuanZhuViewController.h"
#import "CustomTabBar.h"
#import "PostViewController.h"

static const int TAB_W = 33;
static const int MID_BTN_W = 45;
static const int PADDING = 20;
static const int BTN_NUM = 4;
static const int TAB_PADDING_TOP = 5;
static const int TAB_H = 40;

@interface MainViewController ()
{
    UINavigationController *naviVc;
    UIViewController *vc1;
    UINavigationController *vc2;
    UIViewController *vc3;
    UIViewController *vc4;
    UIViewController *naviRootVc;
    
    GuanZhuViewController *guanzhuVc;
  
    PostViewController *tmpVc;
    UIView *oye2TabBar;
    NSMutableArray *customTabBarItems;
    UIButton *midButton;
    PostViewController *postVc;
    
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    customTabBarItems = [[NSMutableArray alloc] init];
    
    oye2TabBar = [[UIView alloc] init];
    oye2TabBar.frame = CGRectMake(0, SCREEN_HEIGHT - TABBAR_H, SCREEN_WIDTH, TABBAR_H);
    oye2TabBar.backgroundColor = ARGBCOLOR(0xf8, 0xf8, 0xf8, 0.95);
    oye2TabBar.layer.borderColor = RGBCOLOR(0xc1, 0xc1, 0xc3).CGColor;
    oye2TabBar.layer.borderWidth = 0.5;
    
    
    
    // Do any additional setup after loading the view.
    guanzhuVc = [[GuanZhuViewController alloc] init];
    vc1 = [[UINavigationController alloc] initWithRootViewController:guanzhuVc];
    
    
    UIViewController *vc2SubVc = [[UIViewController alloc] init];
    UIView *vc2subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [vc2SubVc.view addSubview:vc2subView];
    vc2subView.backgroundColor = RGBCOLOR(216, 45, 45);
    vc2 = [[UINavigationController alloc] initWithRootViewController:vc2SubVc];
    
    
    vc3 = [[UIViewController alloc] init];
    vc4 = [[UIViewController alloc] init];
    UIView *Vc4_SubView = [[UIView alloc] initWithFrame:
                           CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_VIEW_BOTTOM)];
    Vc4_SubView.backgroundColor = [UIColor greenColor];
    [vc4.view addSubview:Vc4_SubView];
    
    UIView *Vc3_SubView = [[UIView alloc] initWithFrame:
                           CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_VIEW_BOTTOM)];
    Vc3_SubView.backgroundColor = ARGBCOLOR(10, 167, 216, 1.0);
    [vc3.view addSubview:Vc3_SubView];
    
    naviRootVc = [[UIViewController alloc] init];
    UIView *naviRootVcSubView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_VIEW_HEAD - TAB_VIEW_BOTTOM)];
    naviRootVcSubView.backgroundColor = [UIColor redColor];
    [naviRootVc.view addSubview:naviRootVcSubView];
    naviVc = [[UINavigationController alloc] initWithRootViewController:naviRootVc];
    naviVc.navigationBarHidden = YES;
    
    
    
    float gap = (SCREEN_WIDTH - TAB_W * BTN_NUM - PADDING * 2 - MID_BTN_W) / BTN_NUM;
    
    for (int i = 0; i < 4; i++) {
        
        NSString *normalImageStr = [NSString stringWithFormat:@"nav%d.png", i+1];
        NSString *selectedImageStr = [NSString stringWithFormat:@"nav%dp.png", i+1];
        CustomTabBar *oyeTab = [[CustomTabBar alloc] initWithNormalStateImage:[UIImage imageNamed:normalImageStr] andSelectedStateImage:[UIImage imageNamed:selectedImageStr]];
        oyeTab.tabBarTag = i+1;
        [oyeTab switchToNormalState];
        oyeTab.delegate = self;
        
        [customTabBarItems addObject:oyeTab];
        
        if (i == 0) {
            [oyeTab switchToSelectedState];
            oyeTab.frame = CGRectMake(PADDING, TAB_PADDING_TOP, TAB_W, TAB_H);
        } else if (i == 1){
            oyeTab.frame = CGRectMake(PADDING + gap + TAB_W, TAB_PADDING_TOP, TAB_W, TAB_H);
        } else if (i == 2){
            oyeTab.frame = CGRectMake(PADDING + MID_BTN_W + TAB_W * i + gap * (i + 1), TAB_PADDING_TOP, TAB_W, TAB_H);
        } else if (i == 3){
            oyeTab.frame = CGRectMake(PADDING + MID_BTN_W + TAB_W * i + gap * (i + 1), TAB_PADDING_TOP, TAB_W, TAB_H);
        }
        
        [oye2TabBar addSubview:oyeTab];
    }
 
        
    self.viewControllers = [NSArray arrayWithObjects:vc1, naviVc, vc2, vc3, nil];
    self.selectedViewController = vc1;

    [self.tabBar setHidden:YES];
    
    midButton = [[UIButton alloc] init];
    midButton.frame = CGRectMake((SCREEN_WIDTH - 45) / 2, SCREEN_HEIGHT - TABBAR_H + 5, 45, 37);
    [midButton setImage:[UIImage imageNamed:@"nav5.png"] forState:UIControlStateNormal];
    [midButton setImage:[UIImage imageNamed:@"nav5p.png"] forState:UIControlStateSelected];
    
    [midButton addTarget:self action:@selector(pressMidButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:oye2TabBar];
    
    [self.view addSubview:midButton];
}

- (void)pressMidButton:(UIButton *)sender
{
    NSLog(@"mid press!");
    if (!postVc) {
        postVc = [[PostViewController alloc] init];
    }
 
    UIView *postView = postVc.view;
    [self.view addSubview:postView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(cleanPostVc)
                                                 name:EVENT_CLOSE_POST_VIEW
                                                object:nil];
    
    return;

}

- (void)cleanPostVc{
    if (postVc.view.superview) {
        [postVc.view removeFromSuperview];
    }
    postVc = nil;
}

- (void)tabBarDidTapped:(id)sender
{
    CustomTabBar *tabBar = (CustomTabBar *)sender;
    
    int tabIndex = [tabBar tabBarTag];
    
    for (CustomTabBar *tab in customTabBarItems) {
        [tab switchToNormalState];
    }
    [tabBar switchToSelectedState];
    
    UIViewController *vc = [self.viewControllers objectAtIndex:(tabIndex - 1)];
    self.selectedViewController = vc;
    
    NSLog(@"tab press");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewWillLayoutSubviews in MainView");
    //[self.navigationController setNavigationBarHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
