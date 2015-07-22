//
//  ExplorViewController.m
//  oye2
//
//  Created by Lee on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ExplorViewController.h"
#import "OyePathTableViewCell.h"


static const int HEAD_BTN_H = 24;
static const int HEAD_BTN_W = 52;
static const int HEAD_BTN_PADDING_TOP = 29;
static const int BTN_TAB_OFFSET = 1000;
static const int CAT_BAR_H = 34;
static const int CAT_KID_W = 9;
static const int CAT_KID_H = 6;


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
    
    NSMutableArray *catStateArray;
    NSMutableArray *catSortArray;
    
    UIButton *catStateBtn;
    UIButton *catSortBtn;
    
    UIView *stateListView;
    
    UITableView *catTableView;
    
    //NSArray *randImgs;
}

@end

@implementation ExplorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fechStateAndSortAatas];
    
    [self createContentView];
    [self createPathView];
    
    [self createCatTableView];
    [self createHead];
    [self createPathAndUserBtn];
    
    
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

- (void)fechStateAndSortAatas
{
    NSArray *testStateArray = @[@"全部状态", @"等待上线", @"投资进行中", @"报名进行中", @"已完成"];
    NSArray *testSortArray = @[@"默认排序", @"按时间", @"最少筹资", @"最高筹资"];
    
    NSUInteger len = [testStateArray count];
    if (catStateArray == nil) {
        catStateArray = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < len; i++) {
        [catStateArray addObject:[testStateArray objectAtIndex:i]];
    }
    
    
    len = [testSortArray count];
    if (catSortArray == nil) {
        catSortArray = [[NSMutableArray alloc] init];
        
    }
    for (int i = 0; i < len; i++) {
        [catSortArray addObject:[testSortArray objectAtIndex:i]];
    }
    
    
    
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
    
    
    float labelWidth = 64.0;
    float labelHeight = 16;
    catLabelState = [[UILabel alloc] init];
    catLabelState.frame = CGRectMake((SCREEN_WIDTH / 2 - labelWidth) / 2, (CAT_BAR_H - labelHeight)/2, labelWidth, labelHeight);
    catLabelState.text = @"全部状态";
    catLabelState.font = [UIFont systemFontOfSize:16];
    catLabelState.textColor = RGBCOLOR(0x75, 0x75, 0x75);
    [catbar addSubview:catLabelState];
    
    catLabelSort = [[UILabel alloc] init];
    catLabelSort.frame = CGRectMake(SCREEN_WIDTH / 2 + (SCREEN_WIDTH / 2 - labelWidth) / 2, (CAT_BAR_H - labelHeight)/2, labelWidth, labelHeight);
    catLabelSort.text = @"默认排序";
    catLabelSort.font = [UIFont systemFontOfSize:16];
    catLabelSort.textColor = RGBCOLOR(0x75, 0x75, 0x75);
    [catbar addSubview:catLabelSort];
    
    
    catStateBtn = [[UIButton alloc] init];
    catStateBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, CAT_BAR_H);
    int gap = 5;
    catStateBtn.imageEdgeInsets = UIEdgeInsetsMake((CAT_BAR_H - CAT_KID_H)/2, catLabelState.frame.origin.x + 64 + gap, (CAT_BAR_H - CAT_KID_H)/2, SCREEN_WIDTH/2 - catLabelState.frame.origin.x - 64 - CAT_KID_W - gap);
    [catStateBtn setImage:[UIImage imageNamed:@"catDown.png"] forState:UIControlStateNormal];
    [catbar addSubview:catStateBtn];
    
    [catStateBtn addTarget:self action:@selector(pressCatBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    stateListView = [[UIView alloc] init];
    stateListView.frame = CGRectMake(0, CAT_BAR_H, SCREEN_WIDTH/2, [catStateArray count] * 30);
    NSLog(@"%lu", (unsigned long)[catStateArray count]);
    stateListView.backgroundColor = ARGBCOLOR(0xff, 0xff, 0xff, 0.95);
    
    NSUInteger len = [catStateArray count];
    for (int i = 0; i < len; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0.5, i * 30, SCREEN_WIDTH/ 2 - 1, 30);
        [btn setTitle:[catStateArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn setTitleColor:RGBCOLOR(0x00, 0xaa, 0xff) forState:UIControlStateHighlighted];
        [btn setTitleColor:RGBCOLOR(0x75, 0x75, 0x76) forState:UIControlStateNormal];
        
        [stateListView addSubview:btn];
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, (i + 1) * 30, SCREEN_WIDTH / 2, 0.5);
        if (i == (len - 1)) {
            line.backgroundColor = RGBCOLOR(0x00, 0xaa, 0xff);
        }else{
            line.backgroundColor = RGBCOLOR(0xe3, 0xe6, 0xe9);
        }
        [stateListView addSubview:line];
    }
    [pathView addSubview:stateListView];
    
}

- (void)createCatTableView
{
    if(catTableView == nil){
        catTableView = [[UITableView alloc] init];
        catTableView.frame = CGRectMake(0, HEAD_H + CAT_BAR_H, SCREEN_WIDTH, SCREEN_HEIGHT - HEAD_H - CAT_BAR_H - TABBAR_H);
        [pathView addSubview:catTableView];
        catTableView.delegate = self;
        catTableView.dataSource = self;
    }
    
    catTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:catTableView];
    
    
}

- (void)createUserView
{
    
}

#pragma mark - UITableView   Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 159.0 + 1.0 + 1.0;
}

#pragma mark - UITableView    DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pathTabelCell = @"LeePathTabelCell";
    OyePathTableViewCell *cell;
    cell = [catTableView dequeueReusableCellWithIdentifier:pathTabelCell];
    if (cell == nil) {
        cell = [[OyePathTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pathTabelCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSString *lStr = [NSString stringWithFormat:@"testPathImg0%d.png", arc4random() % 16];
        
        NSString *rStr = [NSString stringWithFormat:@"testPathImg0%d.png", arc4random() % 16];
        
        NSLog(@"%@ #### %@", lStr, rStr);
        [cell initWithType:PathTypeWaitting andImageLeft:[UIImage imageNamed:lStr] andImageRight:[UIImage imageNamed:rStr] andInfo:@"hello"];
    }
    
    return cell;
}

#pragma mark - Press Cat Btn
- (void)pressCatBtn:(UIButton *)btn
{
    NSLog(@"press Cat Btn");
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
