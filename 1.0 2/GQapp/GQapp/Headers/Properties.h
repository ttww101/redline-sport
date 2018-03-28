//
//  Properties.h
//  GunQiuLive
//
//  Created by WQ_h on 15/12/22.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//

#ifndef GunQiuLive_Properties_h
#define GunQiuLive_Properties_h
//color
#define ColorWithRGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
//16精制颜色
#define UIColorFromRGBWithOX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//默认红色
#define redcolor UIColorFromRGBWithOX(0xea4335)
#define yellowcolor UIColorFromRGBWithOX(0xfbbc05)
#define bluecolor UIColorFromRGBWithOX(0x4285f4)
#define greencolor UIColorFromRGBWithOX(0x34a853)
#define color34a853 UIColorFromRGBWithOX(0x34a853)

#define redcolorAlpha ColorWithRGBA(252, 68, 72, 0.5)

#define navTextColor ColorWithRGBA(39, 39, 39, 1)
#define navColor ColorWithRGBA(247,247,247,1)

//平
#define greePingColor ColorWithRGBA(253, 94, 30, 1)
//负
#define buleLoseColor  ColorWithRGBA(135, 135, 135, 1)


#define greeNews  ColorWithRGBA(136, 202, 112, 1)
#define blueNews  ColorWithRGBA(60, 140, 254, 1)

#define juSeColor  ColorWithRGBA(254, 102, 0, 1)

//基本面的颜色改变
#define color00b93d  ColorWithRGBA(0, 185, 61, 1)
#define colorffb400  ColorWithRGBA(255, 180, 0, 1)

//69, 138, 202

//比分页面的推荐爆料字的边框
#define blue1Color ColorWithRGBA(52, 170, 242, 1)
//完场的时候比分颜色
#define green1Color ColorWithRGBA(147, 197, 61, 1)
//爆料 中立 的颜色
#define redSimmpleColor ColorWithRGBA(216, 180, 180, 1)
//比赛中的比分颜色
#define green2Color ColorWithRGBA(43, 154, 34, 1)
//比分页选中比赛状态的颜色  “全部，未开始，。。。”
#define yellowColor1 ColorWithRGBA(255, 198, 97, 1)
//情报页上面选择日期的背景颜色
#define yellowColor2 ColorWithRGBA(255, 245, 231, 1)

//比分页没有选中比赛状态的颜色
#define whiteColor1 ColorWithRGBA(255, 194, 194, 1)

#define grayColor4 ColorWithRGBA(51,51,51,1)
#define grayColor34 ColorWithRGBA(102,102,102,1)
#define grayColor3 ColorWithRGBA(153,153,153,1)
#define grayColor2 ColorWithRGBA(201,201,201,1)
#define grayColor1 ColorWithRGBA(247,247,247,1)
#define grayColorBottomLine ColorWithRGBA(221,221,221,1)

//新版的颜色
#define BGColorAll1  ColorWithRGBA(229, 229, 229,1)//背景颜色

#define BalckColor1 ColorWithRGBA(82,82,82,1)//525252


//键盘颜色
#define colorKeyboard ColorWithRGBA(187,194,201,1)
//发送评论按钮
#define colorSendComment ColorWithRGBA(130,200,101,1)
//爆料字体颜色
#define colorInfo ColorWithRGBA(239,147,72,1)

//欧洲杯颜色
#define colorBlue1 ColorWithRGBA(14,50,105,1)
#define colorBlue2 ColorWithRGBA(7,93,160,1)
#define colorBlue3 ColorWithRGBA(204,237,255,1)
//竞猜比赛的按钮颜色
#define colorYellow1 ColorWithRGBA(255, 242, 176, 1)
//红包字体颜色
#define colorYellow2 ColorWithRGBA(242, 211, 59, 1)
#define colorList1 ColorWithRGBA(247, 173, 43, 1)
#define colorList2 ColorWithRGBA(210, 71, 71, 1)
#define colorList3 ColorWithRGBA(244, 111, 64, 1)
#define colorYellow2 ColorWithRGBA(242, 211, 59, 1)

#define color66 ColorWithRGBA(102, 102, 102, 1)
//绿色 联赛名称
#define color6C9E1E ColorWithRGBA(108,158,30, 1)
//VS
#define color74 ColorWithRGBA(116,116,116, 1)
//球队名称
#define color52 ColorWithRGBA(82,82,82, 1)
#define color40 ColorWithRGBA(64,64,64, 1)
#define color99 ColorWithRGBA(153,153,153, 1)
#define colorBE ColorWithRGBA(190,190,190, 1)
//线条颜色
#define colorE5 ColorWithRGBA(229,229,229, 1)
#define colorFF6600 ColorWithRGBA(255,102,0, 1)
#define colorDE ColorWithRGBA(222,222,222, 1)
//蓝色
#define color34AAF2 ColorWithRGBA(52,170,242, 1)
//#define colorF7 ColorWithRGBA(247,247,247, 1)
//进行中比分颜色
#define color26BF1E ColorWithRGBA(38,191,30, 1)
//黄牌颜色
#define colorF6E422 ColorWithRGBA(246,228,34, 1)

#define colorFECA2A UIColorFromRGBWithOX(0xfbbc05)
#define colorFEC231 UIColorFromRGBWithOX(0xfbbc05)
#define color4BC9F8 UIColorFromRGBWithOX(0x4bc9f8)
#define colorE4EEFB UIColorFromRGBWithOX(0xe4eefb)
#define color4E37DB UIColorFromRGBWithOX(0x4e37db)

#define colorDEE6DE UIColorFromRGBWithOX(0xeeeeee)
#define colorEEEEEE UIColorFromRGBWithOX(0xEEEEEE)
#define color999999 UIColorFromRGBWithOX(0x999999)

#define colorFFFFFF UIColorFromRGBWithOX(0xFFFFFF)
#define colorF7 UIColorFromRGBWithOX(0xf7f7f7)
#define colorF5 UIColorFromRGBWithOX(0xf5f5f5)
#define colorFA UIColorFromRGBWithOX(0xfafafa)
#define colorEC UIColorFromRGBWithOX(0xececec)
#define colorFEF4F3 UIColorFromRGBWithOX(0xfef4f3)
#define colorFEF1F0 UIColorFromRGBWithOX(0xfef1f0)
#define colorFFFD4D UIColorFromRGBWithOX(0xfbbc05)
#define colorFE UIColorFromRGBWithOX(0xfefefe)
#define colorCC UIColorFromRGBWithOX(0xcccccc)
#define colorEE UIColorFromRGBWithOX(0xeeeeee)
#define color88CA70 UIColorFromRGBWithOX(0x34a853)
#define colorD6 UIColorFromRGBWithOX(0xd6d6d6)
#define colorDD UIColorFromRGBWithOX(0xdddddd)
#define colorE3 UIColorFromRGBWithOX(0xeeeeee)
#define colorE8 UIColorFromRGBWithOX(0xe8e8e8)
#define colorEa UIColorFromRGBWithOX(0xea4335)
#define colorF5A19A UIColorFromRGBWithOX(0xf5a19a)
#define colorD8CB29 UIColorFromRGBWithOX(0xd8cb29)

#define color27 UIColorFromRGBWithOX(0x272727)
#define color33 UIColorFromRGBWithOX(0x333333)
#define colorFFC5BF UIColorFromRGBWithOX(0xffc5bf)
#define colorFB9A81 UIColorFromRGBWithOX(0xfb9a81)
#define colorFFFFDF UIColorFromRGBWithOX(0xffffdf)
#define colorFF9900 UIColorFromRGBWithOX(0xfbbc05)
#define color4C8DE5 UIColorFromRGBWithOX(0x4285F4)
#define colorFBAF04 UIColorFromRGBWithOX(0xfbbc05)
#define colorFEE3E1 UIColorFromRGBWithOX(0xfee3e1)
#define colorFFD8D6 UIColorFromRGBWithOX(0xfee3e1)
#define color4A90E2 UIColorFromRGBWithOX(0x4285f4)
#define colorf5f5f5 UIColorFromRGBWithOX(0xf5f5f5)
#define colorfbfafa UIColorFromRGBWithOX(0xfbfafa)
#define colorfbbc05 UIColorFromRGBWithOX(0xfbbc05)
#define colorf3f4f5 UIColorFromRGBWithOX(0xf3f4f5)
#define colorf66666 UIColorFromRGBWithOX(0x666666)
#define colorf33333 UIColorFromRGBWithOX(0x333333)
#define colorf86868 UIColorFromRGBWithOX(0x868686)

#define colorfc4448 UIColorFromRGBWithOX(0xfc4448)
#define color07BDEB UIColorFromRGBWithOX(0x07bdeb)
#define color33A1FF UIColorFromRGBWithOX(0x33a1ff)

#define colorTableViewBackgroundColor UIColorFromRGBWithOX(0xf5f5f5)
#define colorCellLine UIColorFromRGBWithOX(0xdddddd)
#define cellLineColor UIColorFromRGBWithOX(0xdddddd)

#define colorf99c07 UIColorFromRGBWithOX(0xf99c07)

#define colorffba12 UIColorFromRGBWithOX(0xFFBA12)
#define colorE4a100 UIColorFromRGBWithOX(0xe4a100)
#define color45c4ee UIColorFromRGBWithOX(0x45c4ee)



















#endif

