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
    label.backgroundColor = [UIColor blueColor];
    [self.view addSubview:label];
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
