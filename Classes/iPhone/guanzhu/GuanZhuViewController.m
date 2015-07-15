//
//  GuanZhuViewController.m
//  oye2
//
//  Created by Lee on 15/7/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GuanZhuViewController.h"

#define BANNER_H 184
#define BANNER_IMG_NUM 4
@interface GuanZhuViewController (){
    UIView *head;
    UIView *headBottomLine;
    UIImageView *oyeImg;
    UIView *mainView;
    UIScrollView *bannerHolder;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
}

@end

@implementation GuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainView = [[UIView alloc] init];
    mainView.frame = CGRectMake(0, HEAD_H, SCREEN_WIDTH, SCREEN_HEIGHT - HEAD_H);
    mainView.backgroundColor = RGBCOLOR(0xf3, 0xf6, 0xf9);
    //mainView.scrollEnabled = NO;
    //mainView.userInteractionEnabled = NO;
    //mainView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:mainView];
    
    
    
    bannerHolder = [[UIScrollView alloc] init];
    bannerHolder.frame = CGRectMake(0, 0, SCREEN_WIDTH, BANNER_H);
    bannerHolder.contentSize = CGSizeMake(SCREEN_WIDTH * BANNER_IMG_NUM, BANNER_H);
    bannerHolder.backgroundColor = ARGBCOLOR(0xff, 0xff, 0, 0x12);
    self.automaticallyAdjustsScrollViewInsets = NO;
    bannerHolder.showsHorizontalScrollIndicator = NO;
    bannerHolder.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    bannerHolder.showsVerticalScrollIndicator = NO;
    bannerHolder.pagingEnabled = YES;
    bannerHolder.delegate = self;
    bannerHolder.bounces = NO;
    [mainView addSubview:bannerHolder];
    
    //generate banner img
    for (int i = 0; i < BANNER_IMG_NUM; i++) {
        UIImageView *tempView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testbanner.png"]];
        tempView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, BANNER_H);
        [bannerHolder addSubview:tempView];
    }
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, BANNER_H - 50, SCREEN_WIDTH, 50);
    //pageControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    pageControl.numberOfPages = BANNER_IMG_NUM;
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [mainView addSubview:pageControl];
    
    self.navigationController.navigationBarHidden = YES;
    head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEAD_H)];
    head.backgroundColor = RGBCOLOR(236, 236, 0xec);
    [self.view addSubview:head];
    
    oyeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oyeLogo.png"]];
    float oyeImgX = (SCREEN_WIDTH - 119) / 2;
    float oyeImgY = STATE_BAR_H + (HEAD_H - 20 - 34) / 2;
    oyeImg.frame = CGRectMake(oyeImgX, oyeImgY, 119, 34);
    [self.view addSubview:oyeImg];
    
    headBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, HEAD_H - 0.5, SCREEN_WIDTH, 0.5)];
    headBottomLine.backgroundColor = RGBCOLOR(0xaa, 0xaa, 0xac);
    [self.view addSubview:headBottomLine];
    
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}

#pragma mark - pageContrller change page

- (void)pageChange:(id)sender
{
    long page = pageControl.currentPage;
    [bannerHolder setContentOffset:CGPointMake(page * SCREEN_WIDTH, 0)];
    pageControlUsed = YES;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"begin");
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    pageControlUsed = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pageControlUsed) {
        return;
    }
    int page = floor((scrollView.contentOffset.x - SCREEN_WIDTH / 2) / SCREEN_WIDTH + 1);
    pageControl.currentPage = page;
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
