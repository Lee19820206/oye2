//
//  GuanZhuViewController.m
//  oye2
//
//  Created by Lee on 15/7/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GuanZhuViewController.h"
#import "WelcomeViewController.h"


#define BANNER_IMG_NUM 8
#define FOUR_BTNS_BG_H 80
#define FOUT_BTNS_PADDING 32
#define GAP_BANNER_AND_FOURBTN 20
#define GAP_BETWEEN_HOT 10
#define HOT_H 93
#define HOT_SPAN 10
#define DATA_H 60

static const int hot_h = 93;
static float BANNER_H;
static float zanKidW = 24;

@interface GuanZhuViewController (){
    UIView *head;
    UIView *headBottomLine;
    UIImageView *oyeImg;
    UIScrollView *mainView;
    UIScrollView *bannerHolder;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    CGFloat mainViewContentH;
    long timerCount;
    
}

@end

@implementation GuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BANNER_H = SCREEN_WIDTH * 430 / 750;
    
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;  //scrollview 顶部留白
    
    
    mainView = [[UIScrollView alloc] init];
    mainView.frame = CGRectMake(0, HEAD_H, SCREEN_WIDTH, SCREEN_HEIGHT - HEAD_H - TABBAR_H);
    mainView.backgroundColor = RGBCOLOR(0xf3, 0xf6, 0xf9);
    
    mainView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:mainView];
    
    
    // init bannerHolder
    bannerHolder = [[UIScrollView alloc] init];
    bannerHolder.frame = CGRectMake(0, 0, SCREEN_WIDTH, BANNER_H);
    bannerHolder.contentSize = CGSizeMake(SCREEN_WIDTH * BANNER_IMG_NUM, BANNER_H);
    bannerHolder.backgroundColor = ARGBCOLOR(0xff, 0xff, 0, 0x12);
    bannerHolder.showsHorizontalScrollIndicator = NO;
    //bannerHolder.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    bannerHolder.showsVerticalScrollIndicator = NO;
    bannerHolder.pagingEnabled = YES;
    bannerHolder.delegate = self;
    bannerHolder.bounces = NO;
    [mainView addSubview:bannerHolder];
    
    //generate banner images
    for (int i = 0; i < BANNER_IMG_NUM; i++) {
        UIImageView *tempView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"750-430banner%d.png", i+1]]];
        tempView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, BANNER_H);
        [bannerHolder addSubview:tempView];
    }
    
    //create pageControl
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, BANNER_H - 54, SCREEN_WIDTH, 50);
    pageControl.numberOfPages = BANNER_IMG_NUM;
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [mainView addSubview:pageControl];
    
    //nstimer
    timerCount = 0;
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(turnToNextPage) userInfo:nil repeats:YES];
    
    //create four btns
    [self createFourBtns];

    //项目天使投
    [self createTST];
    
    //项目待秒杀
    [self createDMS];
    
    UIView *datasView = [[UIView alloc] init];
    datasView.frame = CGRectMake(10, BANNER_H + FOUR_BTNS_BG_H + 20 + (GAP_BETWEEN_HOT + HOT_H * 2) * 2, SCREEN_WIDTH - HOT_SPAN * 2, DATA_H * 2);
    datasView.backgroundColor = [UIColor whiteColor];
    datasView.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    datasView.layer.borderWidth = 0.5;
    UIView *midLine = [[UIView alloc] init];
    midLine.frame = CGRectMake(0, datasView.frame.size.height/2, datasView.frame.size.width, 0.5);
    midLine.backgroundColor =  RGBCOLOR(0xe3, 0xe6, 0xe9);
    [datasView addSubview:midLine];
    
    UIView *centerLine1 = [[UIView alloc] init];
    centerLine1.frame = CGRectMake(datasView.frame.size.width/2, 10, 0.5, DATA_H - 10 *2);
    centerLine1.backgroundColor =  RGBCOLOR(0xe3, 0xe6, 0xe9);
    [datasView addSubview:centerLine1];
    
    UIView *centerLine2 = [[UIView alloc] init];
    centerLine2.frame = CGRectMake(datasView.frame.size.width/2, DATA_H + 10, 0.5, DATA_H - 10 *2);
    centerLine2.backgroundColor =  RGBCOLOR(0xe3, 0xe6, 0xe9);
    [datasView addSubview:centerLine2];
    
    /*
     *---------------------*
     | data1    | data5    |
     | data2    | data6    |
     *---------------------*
     | data3    | data7    |
     | data4    | data8    |
     *---------------------*
     */
    UILabel *data1Txt = [[UILabel alloc] init];
    data1Txt.frame = CGRectMake(10, 10, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data1Txt.text = @"1688888888";
    data1Txt.font = [UIFont boldSystemFontOfSize:18];
    data1Txt.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    [datasView addSubview:data1Txt];
    
    UILabel *data2Txt = [[UILabel alloc] init];
    data2Txt.frame = CGRectMake(10, 35, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data2Txt.text = @"预约投资金额";
    data2Txt.font = [UIFont systemFontOfSize:14];
    data2Txt.textColor = RGBCOLOR(153, 153, 153);
    [datasView addSubview:data2Txt];
    
    UILabel *data3Txt = [[UILabel alloc] init];
    data3Txt.frame = CGRectMake(10, DATA_H + 10, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data3Txt.text = @"8888888";
    data3Txt.font = [UIFont boldSystemFontOfSize:18];
    data3Txt.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    [datasView addSubview:data3Txt];
    
    UILabel *data4Txt = [[UILabel alloc] init];
    data4Txt.frame = CGRectMake(10, DATA_H + 35, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data4Txt.text = @"会员总数";
    data4Txt.font = [UIFont systemFontOfSize:14];
    data4Txt.textColor = RGBCOLOR(153, 153, 153);
    [datasView addSubview:data4Txt];
    
    UILabel *data5Txt = [[UILabel alloc] init];
    data5Txt.frame = CGRectMake(datasView.frame.size.width/2 + 10, 10, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data5Txt.text = @"68686775";
    data5Txt.font = [UIFont boldSystemFontOfSize:18];
    data5Txt.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    [datasView addSubview:data5Txt];
    
    UILabel *data6Txt = [[UILabel alloc] init];
    data6Txt.frame = CGRectMake(datasView.frame.size.width/2 + 10, 35, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data6Txt.text = @"成功融资金额";
    data6Txt.font = [UIFont systemFontOfSize:14];
    data6Txt.textColor = RGBCOLOR(153, 153, 153);
    [datasView addSubview:data6Txt];
    
    UILabel *data7Txt = [[UILabel alloc] init];
    data7Txt.frame = CGRectMake(datasView.frame.size.width/2 + 10, DATA_H + 10, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data7Txt.text = @"168";
    data7Txt.font = [UIFont boldSystemFontOfSize:18];
    data7Txt.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    [datasView addSubview:data7Txt];
    
    UILabel *data8Txt = [[UILabel alloc] init];
    data8Txt.frame = CGRectMake(datasView.frame.size.width/2 +10, DATA_H + 35, (datasView.frame.size.width - 10 * 2) / 2, 20);
    data8Txt.text = @"项目总数";
    data8Txt.font = [UIFont systemFontOfSize:14];
    data8Txt.textColor = RGBCOLOR(153, 153, 153);
    [datasView addSubview:data8Txt];
    
    mainViewContentH = datasView.frame.origin.y + datasView.frame.size.height;
    [mainView addSubview:datasView];
    
    mainView.contentSize = CGSizeMake(SCREEN_WIDTH, mainViewContentH + 10);
    
    
    //head 顶部背景
    head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEAD_H)];
    head.backgroundColor = RGBCOLOR(236, 236, 0xec);
    [self.view addSubview:head];
    
    //oye 顶部logo
    oyeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oyeLogo.png"]];
    float oyeImgX = (SCREEN_WIDTH - 119) / 2;
    float oyeImgY = STATE_BAR_H + (HEAD_H - 20 - 34) / 2;
    oyeImg.frame = CGRectMake(oyeImgX, oyeImgY, 119, 34);
    [self.view addSubview:oyeImg];
    
    //顶部下面有一条描边
    headBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, HEAD_H - 0.5, SCREEN_WIDTH, 0.5)];
    headBottomLine.backgroundColor = RGBCOLOR(0xaa, 0xaa, 0xac);
    [self.view addSubview:headBottomLine];
    
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}


#pragma mark - Turn To Next Page
- (void)turnToNextPage
{
    timerCount++;
    if (timerCount >= BANNER_IMG_NUM) {
        timerCount = 0;
    }
    [bannerHolder scrollRectToVisible:CGRectMake(timerCount * SCREEN_WIDTH, 0, SCREEN_WIDTH, BANNER_H) animated:YES];
}

#pragma mark - create four btns and bg
- (void)createFourBtns
{
    //4个按钮背景
    UIView *fourBtnsBg = [[UIView alloc] init];
    fourBtnsBg.frame = CGRectMake(0, BANNER_H, SCREEN_WIDTH, FOUR_BTNS_BG_H);
    fourBtnsBg.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:fourBtnsBg];
    
    fourBtnsBg.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    fourBtnsBg.layer.borderWidth = 0.5;
    
    //加入4个按钮
    CGFloat btnW = 37.5;
    CGFloat btnTitleW = 50;
    int btnNum = 4;
    int btnPaddingTop = 13;
    int gap = (int)(((SCREEN_WIDTH - FOUT_BTNS_PADDING * 2) - btnW * btnNum) / (btnNum-1));
    NSArray *btns = @[@"zxxlBtn", @"fhxlBtn", @"wdtzBtn", @"ljdlBtn"];
    NSArray *btnTitles = @[@"最新线路", @"分红线路", @"我的投资", @"立即登录"];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(FOUT_BTNS_PADDING + i * (37.5 + gap), btnPaddingTop + BANNER_H, btnW, btnW);
        //        [btn setTitle:@"btn" forState:UIControlStateNormal];
        //        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[btns objectAtIndex:i],@"1.png"]]
             forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[btns objectAtIndex:i],@"2.png"]]
             forState:UIControlStateHighlighted];
        btn.tag = FOURBTN_TAG_OFFSET + i;
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:btn];
        
        
        UILabel *btnTitle = [[UILabel alloc] init];
        btnTitle.text = [btnTitles objectAtIndex:i];
        btnTitle.textAlignment = NSTextAlignmentCenter;
        btnTitle.textColor = RGBCOLOR(0xa8, 0xa8, 0xa8);
        btnTitle.font = ZBSTYLE_font_smaller;
        btnTitle.frame = CGRectMake(btn.frame.origin.x + (btnW-btnTitleW)/2, BANNER_H + FOUR_BTNS_BG_H - 21, btnTitleW, 12);
        [mainView addSubview:btnTitle];
        
    }

}


- (void)createTST
{
    //项目天使投
    
    
    UIView *hot1 = [[UIView alloc] init];
    hot1.frame = CGRectMake(10, 20 + BANNER_H + FOUR_BTNS_BG_H, SCREEN_WIDTH - 10 * 2, hot_h);
    hot1.backgroundColor = [UIColor whiteColor];
    hot1.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    hot1.layer.borderWidth = 0.5;
    [mainView addSubview:hot1];
    
    UIImageView *hot1Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testTst.png"]];
    hot1Img.frame = CGRectMake(4, 4, 140, 85);
    [hot1 addSubview:hot1Img];
    
    UILabel *hot1Title = [[UILabel alloc] init];
    hot1Title.text = @"双廊的庭院酒店临海有情调";
    hot1Title.font = [UIFont boldSystemFontOfSize:15];
    hot1Title.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10, 20, 140, 14);
    [hot1 addSubview:hot1Title];
    
    UILabel *hot1Txt1 = [[UILabel alloc] init];
    hot1Txt1.text = @"已融";
    hot1Txt1.font = [UIFont boldSystemFontOfSize:12];
    hot1Txt1.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10, 50, 24, 12);
    [hot1 addSubview:hot1Txt1];
    
    UILabel *hot1Txt2 = [[UILabel alloc] init];
    hot1Txt2.text = @"76.5%";
    hot1Txt2.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    hot1Txt2.font = [UIFont boldSystemFontOfSize:12];
    hot1Txt2.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10 + 24 + 4, 50, 60, 12);
    [hot1 addSubview:hot1Txt2];
    
    UILabel *hot1Txt3 = [[UILabel alloc] init];
    hot1Txt3.text = @"12天后结束";
    hot1Txt3.font = [UIFont boldSystemFontOfSize:12];
    hot1Txt3.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10, 50 + 18, 72, 12);
    [hot1 addSubview:hot1Txt3];
    
    UIButton *tstBtn = [[UIButton alloc] init];
    tstBtn.frame = CGRectMake(SCREEN_WIDTH - 10 * 2 - 6 - 64.5, 50, 64.5, 33.5);
    [tstBtn setImage:[UIImage imageNamed:@"tstBtn1.png"] forState:UIControlStateNormal];
    [tstBtn setImage:[UIImage imageNamed:@"tstBtn2.png" ] forState:UIControlStateHighlighted];
    [hot1 addSubview:tstBtn];
    
    UIImageView *tstKid1 = [[UIImageView alloc] init];
    tstKid1.frame = CGRectMake(hot1.frame.size.width - zanKidW, 0, zanKidW, zanKidW);
    [tstKid1 setImage:[UIImage imageNamed:@"tstKid.png"]];
    [hot1 addSubview:tstKid1];
    
    //////////////
    UIView *hot2 = [[UIView alloc] init];
    hot2.frame = CGRectMake(10, 20 + BANNER_H + FOUR_BTNS_BG_H + hot_h, SCREEN_WIDTH - 10 * 2, hot_h);
    hot2.backgroundColor = [UIColor whiteColor];
    hot2.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    hot2.layer.borderWidth = 0.5;
    [mainView addSubview:hot2];
    
    UIImageView *hot2Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testTst2.png"]];
    hot2Img.frame = CGRectMake(4, 4, 140, 85);
    [hot2 addSubview:hot2Img];
    
    UILabel *hot2Title = [[UILabel alloc] init];
    hot2Title.text = @"双廊的庭院酒店临海有情调";
    hot2Title.font = [UIFont boldSystemFontOfSize:15];
    hot2Title.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10, 20, 140, 14);
    [hot2 addSubview:hot2Title];
    
    UILabel *hot2Txt1 = [[UILabel alloc] init];
    hot2Txt1.text = @"已融";
    hot2Txt1.font = [UIFont boldSystemFontOfSize:12];
    hot2Txt1.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10, 50, 24, 12);
    [hot2 addSubview:hot2Txt1];
    
    UILabel *hot2Txt2 = [[UILabel alloc] init];
    hot2Txt2.text = @"80.02%";
    hot2Txt2.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    hot2Txt2.font = [UIFont boldSystemFontOfSize:12];
    hot2Txt2.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10 + 24 + 4, 50, 60, 12);
    [hot2 addSubview:hot2Txt2];
    
    UILabel *hot2Txt3 = [[UILabel alloc] init];
    hot2Txt3.text = @"8天后结束";
    hot2Txt3.font = [UIFont boldSystemFontOfSize:12];
    hot2Txt3.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10, 50 + 18, 72, 12);
    [hot2 addSubview:hot2Txt3];
    
    UIButton *tstBtn2 = [[UIButton alloc] init];
    tstBtn2.frame = CGRectMake(SCREEN_WIDTH - 10 * 2 - 6 - 64.5, 50, 64.5, 33.5);
    [tstBtn2 setImage:[UIImage imageNamed:@"tstBtn1.png"] forState:UIControlStateNormal];
    [tstBtn2 setImage:[UIImage imageNamed:@"tstBtn2.png" ] forState:UIControlStateHighlighted];
    [hot2 addSubview:tstBtn2];
    
    UIImageView *tstKid2 = [[UIImageView alloc] init];
    tstKid2.frame = CGRectMake(hot2.frame.size.width - zanKidW, 0, zanKidW, zanKidW);
    [tstKid2 setImage:[UIImage imageNamed:@"tstKid.png"]];
    [hot2 addSubview:tstKid2];
}

- (void)createDMS
{
    //项目待秒杀
    UIView *hot1 = [[UIView alloc] init];
    hot1.frame = CGRectMake(10, 20 + BANNER_H + FOUR_BTNS_BG_H + hot_h * 2 + GAP_BETWEEN_HOT, SCREEN_WIDTH - 10 * 2, hot_h);
    hot1.backgroundColor = [UIColor whiteColor];
    hot1.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    hot1.layer.borderWidth = 0.5;
    [mainView addSubview:hot1];
    
    UIImageView *hot1Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testDms.png"]];
    hot1Img.frame = CGRectMake(4, 4, 140, 85);
    [hot1 addSubview:hot1Img];
    
    UILabel *hot1Title = [[UILabel alloc] init];
    hot1Title.text = @"总有轮回总有平静的时候";
    hot1Title.font = [UIFont boldSystemFontOfSize:15];
    hot1Title.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10, 20, 140, 14);
    [hot1 addSubview:hot1Title];
    
    UILabel *hot1Txt1 = [[UILabel alloc] init];
    hot1Txt1.text = @"等待上线";
    hot1Txt1.textColor = RGBCOLOR(0x6a, 0x6a, 0x6a);
    hot1Txt1.font = [UIFont boldSystemFontOfSize:14];
    hot1Txt1.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10, 50, 100, 12);
    [hot1 addSubview:hot1Txt1];
    
    
    UILabel *hot1Txt2 = [[UILabel alloc] init];
    hot1Txt2.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    hot1Txt2.text = @"10天08:08:08";
    hot1Txt2.font = [UIFont boldSystemFontOfSize:12];
    hot1Txt2.frame = CGRectMake(hot1Img.frame.origin.x + 140 + 10, 50 + 18, 140, 12);
    [hot1 addSubview:hot1Txt2];
    
    UIButton *tstBtn = [[UIButton alloc] init];
    tstBtn.frame = CGRectMake(SCREEN_WIDTH - 10 * 2 - 6 - 64.5, 50, 64.5, 33.5);
    [tstBtn setImage:[UIImage imageNamed:@"dmsBtn1.png"] forState:UIControlStateNormal];
    [tstBtn setImage:[UIImage imageNamed:@"dmsBtn2.png" ] forState:UIControlStateHighlighted];
    [hot1 addSubview:tstBtn];
    
    UIImageView *dmsKid1 = [[UIImageView alloc] init];
    dmsKid1.frame = CGRectMake(hot1.frame.size.width - zanKidW, 0, zanKidW, zanKidW);
    [dmsKid1 setImage:[UIImage imageNamed:@"dmsKid.png"]];
    [hot1 addSubview:dmsKid1];
    
    ////////////////////
    
    UIView *hot2 = [[UIView alloc] init];
    hot2.frame = CGRectMake(10, 20 + BANNER_H + FOUR_BTNS_BG_H + hot_h * 2 + hot_h + GAP_BETWEEN_HOT, SCREEN_WIDTH - 10 * 2, hot_h);
    hot2.backgroundColor = [UIColor whiteColor];
    hot2.layer.borderColor = RGBCOLOR(0xe3, 0xe6, 0xe9).CGColor;
    hot2.layer.borderWidth = 0.5;
    [mainView addSubview:hot2];
    
    UIImageView *hot2Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testDms2.png"]];
    hot2Img.frame = CGRectMake(4, 4, 140, 85);
    [hot2 addSubview:hot2Img];
    
    UILabel *hot2Title = [[UILabel alloc] init];
    hot2Title.text = @"总有轮回总有平静的时候";
    hot2Title.font = [UIFont boldSystemFontOfSize:15];
    hot2Title.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10, 20, 140, 14);
    [hot2 addSubview:hot2Title];
    
    UILabel *hot2Txt1 = [[UILabel alloc] init];
    hot2Txt1.text = @"等待上线";
    hot2Txt1.textColor = RGBCOLOR(0x6a, 0x6a, 0x6a);
    hot2Txt1.font = [UIFont boldSystemFontOfSize:14];
    hot2Txt1.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10, 50, 100, 12);
    [hot2 addSubview:hot2Txt1];
    
    
    UILabel *hot2Txt2 = [[UILabel alloc] init];
    hot2Txt2.textColor = RGBCOLOR(0xff, 0x66, 0x33);
    hot2Txt2.text = @"10天08:08:08";
    hot2Txt2.font = [UIFont boldSystemFontOfSize:12];
    hot2Txt2.frame = CGRectMake(hot2Img.frame.origin.x + 140 + 10, 50 + 18, 140, 12);
    [hot2 addSubview:hot2Txt2];
    
    UIButton *tstBtn2 = [[UIButton alloc] init];
    tstBtn2.frame = CGRectMake(SCREEN_WIDTH - 10 * 2 - 6 - 64.5, 50, 64.5, 33.5);
    [tstBtn2 setImage:[UIImage imageNamed:@"dmsBtn1.png"] forState:UIControlStateNormal];
    [tstBtn2 setImage:[UIImage imageNamed:@"dmsBtn2.png" ] forState:UIControlStateHighlighted];
    [hot2 addSubview:tstBtn2];
    
    UIImageView *dmsKid2 = [[UIImageView alloc] init];
    dmsKid2.frame = CGRectMake(hot2.frame.size.width - zanKidW, 0, zanKidW, zanKidW);
    [dmsKid2 setImage:[UIImage imageNamed:@"dmsKid.png"]];
    [hot2 addSubview:dmsKid2];
    
}

#pragma mark - press four btns
- (void)pressBtn:(UIButton *)sender
{
    NSUInteger tag = sender.tag - FOURBTN_TAG_OFFSET;
    NSLog(@"%lu", (long unsigned)tag);
    UIViewController *vc2SubVc = [[WelcomeViewController alloc] init];
    //UIView *vc2subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //[vc2SubVc.view addSubview:vc2subView];
    //vc2subView.backgroundColor = RGBCOLOR(216, 45, 45);
    [SharedAppDelegate.oyeNavigationVc pushViewController:vc2SubVc animated:YES];
    NSLog(@"%@ vc in oyenavigationvc", SharedAppDelegate.oyeNavigationVc.childViewControllers);
    [SharedAppDelegate.oyeNavigationVc.navigationBar setHidden:YES];
    switch (tag) {
        //最新线路
        case 0:
            
            break;
        //分红线路
        case 2:
            
            break;
        //我的投资
        case 3:
            
            break;
        //立即登录
        case 4:
            
            break;
            
        default:
            break;
    }
}


#pragma mark - pageContrller change page

- (void)pageChange:(id)sender
{
    long page = pageControl.currentPage;
    NSLog(@"page %lu", page);
    [bannerHolder setContentOffset:CGPointMake(page * SCREEN_WIDTH, 0)];
    pageControlUsed = YES;
    
    timerCount = page;
    
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
    timerCount = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
