//
//  PostViewController.m
//  oye2
//
//  Created by Lee on 15/7/18.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PostViewController.h"


static const int BTNS_PADDING = 20;
static const int BTNS_NUM_PER_LINE = 3;
static const int BTN_WIDTH = 72;
static const int BTNS_PADDING_TOP = 150;
static const int BTN_NUM = 6;



@interface PostViewController (){
    
    NSMutableArray *btns;
    
    CGRect *btnWillFrames;
    
    UIButton *closeBtn;
    UIVisualEffectView *blurEffectView;
}

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    self.view.alpha = 0.0;
    if (!btnWillFrames) {
        btnWillFrames = malloc(BTN_NUM * sizeof(CGRect));
    }
    if (!btnWillFrames) {
        return;
    }else{
        NSLog(@"%p", btnWillFrames);
        NSLog(@"CGRect space:%lu", sizeof(CGRect));
        NSLog(@"btnWillFrames space:%lu", sizeof(btnWillFrames));
    }
    if (!blurEffectView) {
        [self createEffetcView];
    }
    
    if (!btns) {
        btns = [[NSMutableArray alloc] init];
        [self createPostBtns];
    }
    if (!closeBtn) {
        [self createCloseBtn];
    }
    
    [self fadeIn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createEffetcView
{
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:blurEffectView];
}

- (void)createPostBtns
{
    float gap = ((SCREEN_WIDTH - BTNS_PADDING * 2) - BTN_WIDTH * BTNS_NUM_PER_LINE) / (BTNS_NUM_PER_LINE - 1);
    for (int i = 0; i<BTN_NUM; i++) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *btnBgStr = [NSString stringWithFormat:@"testPostBtn%i", i];
        [btn setImage:[UIImage imageNamed:btnBgStr] forState:UIControlStateNormal];
        [btns addObject:btn];
        
        btn.frame = CGRectMake(BTNS_PADDING + (int)(i%BTNS_NUM_PER_LINE) * (gap + BTN_WIDTH), BTNS_PADDING_TOP + (int)(i/BTNS_NUM_PER_LINE) * (BTN_WIDTH + gap) + SCREEN_HEIGHT - BTNS_PADDING_TOP + 10, BTN_WIDTH, BTN_WIDTH);
        
        CGRect f = btn.frame;
        f.origin.y = f.origin.y - SCREEN_HEIGHT + BTNS_PADDING_TOP - 10;
        //[btnWillFrames add];
        btnWillFrames[i] = f;
        [self.view addSubview:btn];
  
    }
}

- (void)fadeIn{
    //self.view.alpha = 0.0; see in initUI;
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         self.view.alpha = 1.0;
                     } completion:^(BOOL finished){
                         
                     }];
    
    [self showBtnsWithAnimation];
}

- (void)showBtnsWithAnimation
{
    for (int i = 0; i < BTN_NUM; i++) {
        [UIView animateWithDuration:0.4 delay:(i * 0.05) options:UIViewAnimationOptionCurveEaseOut
                         animations:^(void){
                             ((UIButton *)([btns objectAtIndex:i])).frame = btnWillFrames[i];
                         } completion:nil];
    }
}

- (void)createCloseBtn
{
    closeBtn = [[UIButton alloc] init];
    closeBtn.frame = CGRectMake((SCREEN_WIDTH - 72) / 2, SCREEN_HEIGHT - 72, 72, 72);
    [closeBtn setImage:[UIImage imageNamed:@"testPostBtn5.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(pressCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    //closeBtn.tag = 2000;
    closeBtn.alpha = 0.0;
    [self.view addSubview:closeBtn];
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         closeBtn.alpha = 1.0;
                     } completion:nil];
    
    
    
}

- (void)pressCloseBtn:(UIButton *)btn
{
    for (int i = (BTN_NUM -1); i > -1; i--) {
        [UIView animateWithDuration:0.4 delay:((BTN_NUM - i - 1) * 0.05) options:UIViewAnimationOptionCurveEaseOut
                         animations:^(void){
                             CGRect f = btnWillFrames[i];
                             f.origin.y = f.origin.y + SCREEN_HEIGHT - BTNS_PADDING_TOP + 10;
                             ((UIButton *)([btns objectAtIndex:i])).frame = f;
                         } completion:^(BOOL finished){
                             [((UIButton *)([btns objectAtIndex:i])) removeFromSuperview];
                             if (i == 0) {
                                 [self fadeOutBlurEffectView];
                             }
                         }];
    }
}

- (void)fadeOutBlurEffectView{
    self.view.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^(void){
        self.view.alpha = 0.0;
        closeBtn.alpha = 0.0;
    } completion:^(BOOL finished){
        [blurEffectView removeFromSuperview];
        [closeBtn removeFromSuperview];
        [self clean];
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_CLOSE_POST_VIEW object:nil];
    }];

}

- (void)clean
{
    [btns removeAllObjects];
    btns = nil;
    blurEffectView = nil;
    closeBtn = nil;
    blurEffectView = nil;
    free(btnWillFrames);
}

@end
