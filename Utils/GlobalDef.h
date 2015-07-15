//
//  GlobalDef.h
//  oye2
//
//  Created by Lee on 15-6-9.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#ifndef oye2_GlobalDef_h
#define oye2_GlobalDef_h

#define APP_VERSION @"0.1"

//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

//navigationview顶部的高度
#define NAVIGATION_VIEW_HEAD 64

#define TAB_VIEW_BOTTOM 49

//终于告别讨厌的长长的颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

//终于告别讨厌的长长的颜色再加一个透明度
#define ARGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//app顶部高度
#define HEAD_H 64

//app statuBar 高度
#define STATE_BAR_H 20


#endif
