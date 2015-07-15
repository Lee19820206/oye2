//
//  MainViewController.m
//  oye2
//
//  Created by Lee on 15-6-10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MainViewController.h"
#import "GuanZhuViewController.h"

@interface MainViewController ()
{
    UINavigationController *naviVc;
    UIViewController *vc1;
    UIViewController *vc2;
    UIViewController *vc3;
    UIViewController *vc4;
    UIViewController *naviRootVc;
    
    GuanZhuViewController *guanzhuVc;
    
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    guanzhuVc = [[GuanZhuViewController alloc] init];
    vc1 = [[UINavigationController alloc] initWithRootViewController:guanzhuVc];
    
    vc2 = [[UIViewController alloc] init];
    vc3 = [[UIViewController alloc] init];
    vc4 = [[UIViewController alloc] init];
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
    
    self.viewControllers = [NSArray arrayWithObjects:vc1, naviVc, vc2, vc3, vc4, nil];
    self.selectedViewController = vc1;
    self.tabBar.translucent = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
