//
//  MainViewController.m
//  oye2
//
//  Created by Lee on 15-6-10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MainViewController.h"
#import "GuanZhuViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()
{
    UINavigationController *naviVc;
    UIViewController *vc1;
    UIViewController *vc2;
    UIViewController *vc3;
    UIViewController *vc4;
    UIViewController *naviRootVc;
    
    GuanZhuViewController *guanzhuVc;
    
    UIImageView *tabBtn1;
    UIImageView *tabBtn2;
    UIImageView *tabBtn3;
    UIImageView *tabBtn4;
    UIImageView *tabBtn5;
    
    NSInteger currentId;
    
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
    guanzhuVc = [[GuanZhuViewController alloc] init];
    vc1 = [[UINavigationController alloc] initWithRootViewController:guanzhuVc];
    
    vc2 = [[UIViewController alloc] init];
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
    
    tabBtn1 = [[UIImageView alloc] init];
    tabBtn1.frame = CGRectMake(20, 5, 33, 40);
    [tabBtn1 setImage:[UIImage imageNamed:@"nav1p.png"]];
    [self.tabBar addSubview:tabBtn1];
    
    tabBtn2 = [[UIImageView alloc] init];
    tabBtn2.frame = CGRectMake(73, 5, 33, 40);
    [tabBtn2 setImage:[UIImage imageNamed:@"nav2.png"]];
    [self.tabBar addSubview:tabBtn2];
    
    tabBtn3 = [[UIImageView alloc] init];
    tabBtn3.frame = CGRectMake((SCREEN_WIDTH - 45)/2, 5, 45, 37);
    [tabBtn3 setImage:[UIImage imageNamed:@"nav3.png"]];
    [self.tabBar addSubview:tabBtn3];
    
    tabBtn4 = [[UIImageView alloc] init];
    tabBtn4.frame = CGRectMake(SCREEN_WIDTH - 20 - 33 - 33 - 20, 5, 33, 40);
    [tabBtn4 setImage:[UIImage imageNamed:@"nav4.png"]];
    [self.tabBar addSubview:tabBtn4];
    
    tabBtn5 = [[UIImageView alloc] init];
    tabBtn5.frame = CGRectMake(SCREEN_WIDTH - 20 - 33, 5, 33, 40);
    [tabBtn5 setImage:[UIImage imageNamed:@"nav5.png"]];
    [self.tabBar addSubview:tabBtn5];
    
    
//    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"nav1.png"] selectedImage:[UIImage imageNamed:@"nav1p.png"]];
    
    self.viewControllers = [NSArray arrayWithObjects:vc1, naviVc, vc2, vc3, vc4, nil];
    self.selectedViewController = vc1;
    currentId = 1;
    self.tabBar.translucent = YES;

}


- (void)changeTabBar
{
    int tabId = self.selectedIndex + 1;
    if (tabId == currentId) {
       
        return;
    }
    //NSLog(@"%i", tabId + 1);
    //tabId += 1;
    currentId = tabId;
    
    if (tabId == 1) {
        
        tabBtn1.image = [UIImage imageNamed:@"nav1p.png"];
        tabBtn2.image = [UIImage imageNamed:@"nav2.png"];
        tabBtn3.image = [UIImage imageNamed:@"nav3.png"];
        tabBtn4.image = [UIImage imageNamed:@"nav4.png"];
        tabBtn5.image = [UIImage imageNamed:@"nav5.png"];
    }else if(tabId == 2) {
        
        tabBtn1.image = [UIImage imageNamed:@"nav1.png"];
        tabBtn2.image = [UIImage imageNamed:@"nav2p.png"];
        tabBtn3.image = [UIImage imageNamed:@"nav3.png"];
        tabBtn4.image = [UIImage imageNamed:@"nav4.png"];
        tabBtn5.image = [UIImage imageNamed:@"nav5.png"];
    }else if(tabId == 3) {
        [SharedAppDelegate.oyeNavigationVc pushViewController:vc4 animated:YES];
        tabBtn1.image = [UIImage imageNamed:@"nav1.png"];
        tabBtn2.image = [UIImage imageNamed:@"nav2.png"];
        tabBtn3.image = [UIImage imageNamed:@"nav3p.png"];
        tabBtn4.image = [UIImage imageNamed:@"nav4.png"];
        tabBtn5.image = [UIImage imageNamed:@"nav5.png"];
    }else if(tabId == 4) {
       
        tabBtn1.image = [UIImage imageNamed:@"nav1.png"];
        tabBtn2.image = [UIImage imageNamed:@"nav2.png"];
        tabBtn3.image = [UIImage imageNamed:@"nav3.png"];
        tabBtn4.image = [UIImage imageNamed:@"nav4p.png"];
        tabBtn5.image = [UIImage imageNamed:@"nav5.png"];
    }else if(tabId == 5) {
       
        tabBtn1.image = [UIImage imageNamed:@"nav1.png"];
        tabBtn2.image = [UIImage imageNamed:@"nav2.png"];
        tabBtn3.image = [UIImage imageNamed:@"nav3.png"];
        tabBtn4.image = [UIImage imageNamed:@"nav4.png"];
        tabBtn5.image = [UIImage imageNamed:@"nav5p.png"];
    }
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
