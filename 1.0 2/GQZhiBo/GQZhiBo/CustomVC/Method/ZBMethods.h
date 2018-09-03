//
//  ZBMethods.h
//  GunQiuLive
//
//  Created by WQ_h on 15/11/24.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//
typedef NS_ENUM(NSInteger, weekType)
{
    weekTypeXingqi = 0,
    weekTypeZhou = 1,
};
#import <Foundation/Foundation.h>
#import "ZBUserModel.h"
#import "ZBTokenModel.h"
@interface ZBMethods : NSObject
@property (nonatomic) weekType weektype;
+ (NSArray *)seperateNSString:(NSString *)str
                     bySimple:(NSString *)simple;
//+ (NSDate *)changeDateToChineseDateWithDate:(NSDate *)OOdate;
//获取当前的日期
+ (NSString *)getCurrentDateByStyle:(NSString *)dateStyle;
//获取前后一个月的日期 正数为后，负数为前
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
//获取前后一天的日期
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day;
//获取日期的各个单位的值
+ (NSArray *)getDateByDate:(NSDate *)dateDate withWeekType:(weekType)type;
+ (NSDate *)changeDateToChineseDateWithDate:(NSDate *)OOdate;
//根据指定的日期获取相应的 string 类型的日期
+ (NSString *)getDateByStyle:(NSString *)dateStyle withDate:(NSDate *)date;
+ (int)getIntNumberComparedWithNowDate:(NSString *)nowDate ForDate:(NSString *)date;
+ (int)getIndexNumberForDate:(NSString *)date withNowDate:(NSDate *)nowDate;
//根据字符创的日期换成具体时间
+ (NSDate *)getDateFromString:(NSString *)dateString byformat:(NSString *)format;
//把时间戳换算成时间,超过24小时就换算成时间
+ (NSString *)timeToNowWith:(NSTimeInterval)time;
+ (CATransition *)setTransitionwithType:(NSString *)transitonType;
+ (UIWindow *)getMainWindow;
//图片旋转 UIImage选装
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
+ (UIImage*) imageBlackToTransparent:(UIImage*) image withRed:(float)r Green:(float)g Blue:(float)b;
//判断手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//判断姓名
+ (BOOL)isNameValid:(NSString *)name;
//判断身份证
+ (BOOL) chk18PaperId:(NSString *) sPaperId;

//获取本地documents 的路径,是存储的对象的时候用
+ (NSString *)getDocumentsPath;
//判断两个时间差
+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
+ (NSString *)intervalFromLastDateAnd45: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;
//16进制颜色转变为rgb颜色
+ (UIColor *)getColor:(NSString *)hexColor;
//计算文字的宽度
+ (CGFloat)getTextWidthSize:(NSString *)home strfont:(UIFont *)fontNum;
//文字高度
+ (CGFloat)getTextHeightStationWidth:(NSString *)string anWidthTxtt:(CGFloat)widthText anfont:(CGFloat)fontSize andLineSpace:(CGFloat)linespace andHeaderIndent:(CGFloat)indent;
//给文本设置字体的行间距和第一行的空两个字的距离
+ (NSMutableAttributedString *)setTextStyleWithString:(NSString *)str WithLineSpace:(CGFloat)linespace WithHeaderIndent:(CGFloat)indet;
//md5 加密
+ (NSString *)md5WithString:(NSString *)str;
//获取个人用户信息
+ (ZBUserModel *)getUserModel;
+ (ZBTokenModel *)getTokenModel;
//跟新个人拥护信息
+ (void)updateUsetModel:(ZBUserModel *)model;
+ (void)updateTokentModel:(ZBTokenModel *)model;

+(void)clearUserModel;

//判断是否登录
+ (BOOL)login;
//登录
+ (void)toLogin;
//lab字体不同的颜色
+ (NSMutableAttributedString *)withContent:(NSString *)content contentColor:(UIColor *)contentColor WithColorText:(NSString *)text textColor:(UIColor *)textColor;
//

/**
 lab字体的不同颜色和大小

 */
+ (NSMutableAttributedString *)withContent:(NSString *)content  WithColorText:(NSString *)text  textColor:(UIColor *)textColor strFont:(UIFont *)stringfont;

/**
 btn字体的不同颜色和大小 和原来的字体和大小

 */
+ (NSMutableAttributedString *)withContent:(NSString *)content
                             WithContColor:(UIColor *)ContentColor
                           WithContentFont:(UIFont *)contentFont
                                  WithText:(NSString *)text
                             WithTextColor:(UIColor *)textColor
                              WithTextFont:(UIFont *)textFont;

//更具比赛状态来确定文本的颜色和内容
+ (NSString *)getTextByMatchState:(NSInteger)matchState;
//判断权限
+ (BOOL)panduan:(NSInteger)mode permission:(NSInteger)permission;
//屏幕截图
+ (UIImage *)captureImageFromView:(UIView *)view;
//但是在iOS9以下的版本是没提供这个便利的方法的。以下为解决方案的思路，就是在iOS9以下版本时，先将本地HTML文件的数据copy到tmp目录中，然后再使用loadRequest来加载。但是如果在HTML中加入了其他资源文件，例如js，css，image等必须一同copy到temp中。
+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL;

//获取字符串的宽度
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

//获得字符串的高度
+ (CGFloat) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;


/**
 默认图片
 
 @param imageName 图片名字
 @return 返回图片
 */
+ (UIImage *)defaultPlaceHolderImage:(NSString *)imageName;

+ (NSString *)formatHHSSStamp:(NSUInteger)timeStamp;

+ (NSString *)formatMMDDWithStamp:(NSUInteger)timeStamp;

+ (NSUInteger)formatTimeStr:(NSString *)timeStr;

+ (NSInteger)amountWithProductId:(NSString *)productId;

+ (NSString *)compareCurrentTime:(NSString *)str;

/**
 获取设备型号

 @return 设备型号
 */
+ (NSString*)iphoneType;

+ (NSString *)amountFormater:(NSString *)amountValue;

// 获取当前视图
+ (UIViewController *)help_getCurrentVC;

+ (NSString *)getPersonLeavelImageName:(NSInteger)leavel;

@end
