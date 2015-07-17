//
//  WelcomeViewController.m
//  oye2
//
//  Created by Lee on 15/7/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, (SCREEN_WIDTH - 40) / 2 , SCREEN_WIDTH, 40);
    label.text = @"hello, all!";
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear in welcomeVc");
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


@end
