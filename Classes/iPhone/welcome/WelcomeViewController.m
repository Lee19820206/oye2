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
    self.view.backgroundColor = RGBCOLOR(242, 86, 156);
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 230, 40);
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"oops, 404 is here!";
    UITextField *tf = [[UITextField alloc] init];
    tf.leftView = label;
    tf.leftViewMode = UITextFieldViewModeUnlessEditing;
    tf.backgroundColor = ARGBCOLOR(0xff, 0xff, 0xff, 0.3);
    tf.frame = CGRectMake(0, 100, SCREEN_WIDTH, 40);
    //label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    [self.view addSubview:tf];

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
    //self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
}


@end
