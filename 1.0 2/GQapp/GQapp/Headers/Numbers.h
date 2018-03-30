//
//  Numbers.h
//  GunQiuLive
//
//  Created by WQ_h on 15/12/22.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//
#import "Methods.h"
#ifndef GunQiuLive_Numbers_h
#define GunQiuLive_Numbers_h
#define Zero             (0)
#define UnreadCountTimer (600)
//#define RefreshTokenAndUnreadCountTimer (3600*2)
#define RefreshTokenAndUnreadCountTimer (60*9)
//#define RefreshTokenAndUnreadCountTimer (30)  //测试


#define heightBifenTitleView (44)
#define heightFormLine  (30)
//推荐cell里面的盈利率胜率之间的空隙
#define spaceFanTitle (10)
//统计页面各种统计的cell的高度
#define cellTongjiHeight (29)

//一个13号字所占的高度
#define heightLabtextOneline ([@"一行特定文字的高度" boundingRectWithSize:CGSizeMake(Width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil] context:nil].size.height + 4)//加上4个单位的行间距

#define heightLabtextOnelineWithoutSpace ([@"一行特定文字的高度" boundingRectWithSize:CGSizeMake(Width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil] context:nil].size.height)

#define widthOneWordFont13 ([@"家" boundingRectWithSize:CGSizeMake(Width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil] context:nil].size.width)

//行间距
#define heightLineSpace (4)
//首行开头空得距离
#define heightHeaderIndent (25)

// 请求 token 时间
#define RequestRefreshTokenTime (60*60*1000)
//#define RequestRefreshTokenTime (60*1000*3) // 测试

// 请求 refreshToken 时间
#define OutOfRefreshTokenTime (60*60*1000*24*31*1000)
//#define OutOfRefreshTokenTime (60*1000*5)  //测试



#define PADDING_OF_LEFT_STEP_LINE 21
#define PADDING_OF_LEFT_RIGHT 15
#define WIDTH_OF_PROCESS_LABLE (300 *[UIScreen mainScreen].bounds.size.width / 375)

/**  适配iPhone X  */
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#endif
