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


//btn tag
#define FOURBTN_TAG_OFFSET 1000

//字体
#define ZBSTYLE1_font ([UIFont systemFontOfSize:18])
#define ZBSTYLE2_font ([UIFont systemFontOfSize:17])
#define ZBSTYLE3_font ([UIFont systemFontOfSize:16])
#define ZBSTYLE4_font ([UIFont systemFontOfSize:14])
#define ZBSTYLE5_font ([UIFont systemFontOfSize:15])
#define ZBSTYLE_font ([UIFont systemFontOfSize:14])
#define ZBSTYLE_font_smaller ([UIFont systemFontOfSize:12])
#define ZBSTYLE_tableFont ([UIFont boldSystemFontOfSize:17])
#define ZBSTYLE_highlightedTextColor ([UIColor whiteColor])
#define ZBSTYLE_tableSubTextColor (RGBCOLOR(79, 89, 105))
#define ZBSTYLE_textColor ([UIColor blackColor])

#define English_font_des ([UIFont fontWithName:@"Georgia" size:15])
#define English_font_title ([UIFont fontWithName:@"Georgia-Bold" size:17])
#define English_font_body ([UIFont fontWithName:@"Georgia" size:15])

#define English_font_des_iPad ([UIFont fontWithName:@"Georgia" size:17])
#define English_font_title_iPad ([UIFont fontWithName:@"Georgia-Bold" size:19])
#define English_font_body_iPad ([UIFont fontWithName:@"Georgia" size:17])

#define HotSpot_info_font ([UIFont fontWithName:@"Georgia" size:18])


#endif
