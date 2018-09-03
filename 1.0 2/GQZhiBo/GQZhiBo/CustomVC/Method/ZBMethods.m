//
//  ZBMethods.m
//  GunQiuLive
//
//  Created by WQ_h on 15/11/24.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//

#import "ZBMethods.h"
//md5 加密需要倒入头文件
#import <CommonCrypto/CommonCrypto.h>
#import <sys/utsname.h>

@implementation ZBMethods

+ (NSArray *)seperateNSString:(NSString *)str
                     bySimple:(NSString *)simple
{
    NSArray *arr = [str componentsSeparatedByString:simple];
    return arr;
    return nil;
}
+ (NSString *)timeToNowWith:(NSTimeInterval)time
{
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval IntervalCha =nowInterval -  time/1000 ;
    if (IntervalCha > 3600*24) {
        return [[self getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSince1970:time/1000]]substringWithRange:NSMakeRange(5, 11)];
    }else if (IntervalCha > 3600){
        return  [NSString stringWithFormat:@"%d小时前",(int)IntervalCha/3600];
    }else if (IntervalCha >60){
        return  [NSString stringWithFormat:@"%d分钟前",(int)IntervalCha/60];
    }else{
        return  @"刚刚";
        
    }
    
}

+ (NSDate *)changeDateToChineseDateWithDate:(NSDate *)OOdate
{
    //    NSString *timeSp = [NSString stringWithFormat:@"%lu",(long)[OOdate timeIntervalSince1970]];
    //    long a = [timeSp longLongValue];
    //    long b = a + 3600*8;
    //    NSDate *day = [NSDate dateWithTimeIntervalSince1970:b];
    //    return day;
    
    //    NSDate *dat = [_gregorian dateFromComponents:components];
    NSTimeZone *zong = [NSTimeZone systemTimeZone];
    NSInteger interval = [zong secondsFromGMTForDate:OOdate];
    return [OOdate dateByAddingTimeInterval:interval];
    
    return nil;
}
+ (NSString *)getCurrentDateByStyle:(NSString *)dateStyle
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateStyle];
    return [dateFormatter stringFromDate:date];
}
+ (NSString *)getDateByStyle:(NSString *)dateStyle withDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateStyle];
    return [dateFormatter stringFromDate:date];
}
+ (NSArray *)getDateByDate:(NSDate *)dateDate withWeekType:(weekType)type{
    //年月日 时 周 分
    //yyyy-MM-dd a HH:mm:ss EEEE
    //2012-10-29 下午 16:25:27 星期一
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:dateDate];
    //    int week = [comps weekday];
    //    int year=[comps year];
    //    int month = [comps month];
    //    int day = [comps day];
    NSInteger week = [comps weekday];
    //    NSLog(@"%lu",week);
    NSString *strWeek;
    if (type == weekTypeXingqi) {
        strWeek = [self getweekWithXingqi:week];
    }else if (type == weekTypeZhou)
    {
        strWeek = [self getweekWithZhou:week];
    }
    NSArray *array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)[comps year]],[NSString stringWithFormat:@"%ld",(long)[comps month]],[NSString stringWithFormat:@"%ld",(long)[comps day]],[NSString stringWithFormat:@"%ld",(long)[comps hour]],strWeek,[NSString stringWithFormat:@"%ld",(long)[comps minute]],nil];
    //年月日 时 周 分
    return array;
    return nil;
}

+ (NSString*)getweekWithXingqi:(NSInteger)week
{
    NSString*weekStr=nil;
    switch (week) {
        case 1:
            weekStr=@"星期天";
            break;
        case 2:
            weekStr=@"星期一";
            break;
        case 3:
            weekStr=@"星期二";
            break;
        case 4:
            weekStr=@"星期三";
            break;
        case 5:
            weekStr=@"星期四";
            break;
        case 6:
            weekStr=@"星期五";
            break;
        case 7:
            weekStr=@"星期六";
            break;
        default:
            weekStr = @"星期...";
            break;
    }
    return weekStr;
}
+ (NSString*)getweekWithZhou:(NSInteger)week
{
    NSString*weekStr=nil;
    switch (week) {
        case 1:
            weekStr=@"周日";
            break;
        case 2:
            weekStr=@"周一";
            break;
        case 3:
            weekStr=@"周二";
            break;
        case 4:
            weekStr=@"周三";
            break;
        case 5:
            weekStr=@"周四";
            break;
        case 6:
            weekStr=@"周五";
            break;
        case 7:
            weekStr=@"周六";
            break;
        default:
            weekStr = @"周...";
            break;
    }
    return weekStr;
}

+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    
    return mDate;
    
}
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:day];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    
    return mDate;
    
}


+ (CATransition *)setTransitionwithType:(NSString *)transitonType
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = transitonType; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    return transition;
    return nil;
}

+ (UIWindow *)getMainWindow
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window;
}

+ (int)getIntNumberComparedWithNowDate:(NSString *)nowDate ForDate:(NSString *)date
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:DateFormatter]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* dateDate = [formatter dateFromString:date]; //------------将字符串按formatter转成nsdate
    
    NSDate *nowDateDate = [formatter dateFromString:nowDate];
        NSLog(@"%@",nowDate);
        NSLog(@"%@",date);
    

    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval nowDateInterVal = [nowDateDate timeIntervalSince1970];
    NSTimeInterval forDateInterval = [dateDate timeIntervalSince1970];
    NSLog(@"%f",nowInterval);
    NSLog(@"%f",forDateInterval);
    double differentInterval = forDateInterval - nowDateInterVal;
    int number = differentInterval/(3600*23);
    return number;
}

+ (int)getIndexNumberForDate:(NSString *)date withNowDate:(NSDate *)nowDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DateFormatter];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    int DayInterval = 3600*24;
    
    for ( int i = 0; i<15; i++) {
        NSDate *dateCompare = nil;
        NSString *dateCompareStr = nil;
        dateCompare = [NSDate dateWithTimeInterval:DayInterval*(i-7) sinceDate:nowDate];
        dateCompareStr = [formatter stringFromDate:dateCompare];
        //        NSLog(@"%@ ---- %@",date,dateCompareStr);
        if ([date isEqualToString:dateCompareStr]) {
            return (i-7);
        }
        
    }
    return 0;
}

/*
 
 从大图片上截取小图片
 */
- (UIImage *)getSmallImageByBigImageName:(NSString *)image withRect:(CGRect )rect
{
    
    UIImage *image_bigImage = [UIImage imageNamed:image];
    CGImageRef cgref = image_bigImage.CGImage;
    CGImageRef imageref = CGImageCreateWithImageInRect(cgref, rect);
    UIImage *imageThumbScale = [UIImage imageWithCGImage:imageref];
    CGImageRelease(imageref);
    return imageThumbScale;
    
}
- (void)dictEnum
{
    //    NSDictionary *dict_sport = [[dict_respons objectForKey:@"filter"] objectForKey:@"sport"];
    //
    //    NSArray *arr= dict_sport.allKeys;
    //    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    //        return [obj1 compare:obj2 options:NSNumericSearch];
    //    }];
    //    NSLog(@"%@",arr);
    
    
    //    [dict_sport enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    //        //        NSLog(@"%@",obj);
    //    }];
    
    
    //    NSEnumerator *sportEnum =  dict_sport.keyEnumerator;
    //    id object;
    //    while (object = [sportEnum nextObject]) {
    //        //        NSLog(@"键值为:%@",object);
    //        id objectValue = [dict_sport objectForKey:object];
    //        if (objectValue != nil) {
    //            //            NSLog(@"%@对应的value是:%@",object,objectValue);
    //        }
    //    }
    
}
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}


//更改图片颜色
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
    //遍历图片像素，更改图片颜色
}

+ (UIImage*) imageBlackToTransparent:(UIImage*) image withRed:(float)r Green:(float)g Blue:(float)b
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) == 0x00000000)    // 将白色变成透明
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
        else
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = r; //0~255
            ptr[2] = g;
            ptr[1] = b;
            
        }
        
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}

//设置图片透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//合并2张图片
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image2.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


//将UIImage缩放到指定大小尺寸：
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
+ (BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    
    if (name.length > 1)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = NO;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = NO;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = NO;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = NO;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    
    return isValid;
}

/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */


+(NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger *)value1 Value2:(NSInteger )value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

// * 功能:判断是否在地区码内
// * 参数:地区码
+ (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init] ;
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }return YES;
}

// * 功能:验证身份证是否合法
// * 参数:输入的身份证号
+ (BOOL) chk18PaperId:(NSString *) sPaperId
{
    //判断位数
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if ([sPaperId length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    //判断年月日是否有效
    //年份
    int strYear = [[self getStringWithRange:carid Value1:(long *)6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:(long *)10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:(long *)12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

+ (NSString *)getDocumentsPath
{
    
    
    /*
     （1）Documents：应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
     （2）tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
     （3）Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
     */

    /*
     
     NSSearchPathDomainMask
     NSUserDomainMask是指/user/<userid>/目录，
     
     NSLocalDomainMask，官方文档说是Local to the current machine—the place to install items available to everyone on this machine.还是不太好理解，应该就是跟NSUserDomainMask相对的一个概念，NSUserDomainMask是针对当前用户的，而NSLocalDomainMask是针对所有用户的，比如Library目录，如果是针对用户的，就是/user/<userid>/Library，而对所有用户的就是/Library。
     
     NSNetworkDomainMaskt是指/Network目录下的文件夹。
     
     NSSystemDomainMask是系统目录，现在的Mac在/System目录下只有一个Library目录，这个目录下包含了系统运行的程序和文件。并且所有的SystemDomain的文件夹都是只读的。
     */
    
    
//    NSDocumentDirectory  这个用来存储用户的个人信息，在上面单独写，清楚缓存的时候不清楚个人人的用户信息
    
    
    //存放用户存储的其他信息，不是用户个人信息
//    NSLibraryDirectory
//    NSCachesDirectory
    
    //不要写错参数,找路径
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    //    NSLog(@"%@",documentsPath);
    return documentsPath;
    
}

+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    //    NSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:dateStyleFormatter];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
    NSString *h = @"";
    NSString *m = @"";
    NSString *s = @"";
    
    
    h = [NSString stringWithFormat:@"%d",(int)cha/3600];
    m = [NSString stringWithFormat:@"%d",(int)cha/60];
    s = [NSString stringWithFormat:@"%d",(int)cha%60];
    return m;
}
+ (NSString *)intervalFromLastDateAnd45: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    //    NSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:dateStyleFormatter];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1 + 45*60;
    NSString *h = @"";
    NSString *m = @"";
    NSString *s = @"";
    
    
    h = [NSString stringWithFormat:@"%d",(int)cha/3600];
    m = [NSString stringWithFormat:@"%d",(int)cha/60];
    s = [NSString stringWithFormat:@"%d",(int)cha%60];
    //    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    return m;
}

//去除数组中重复的数据
//+ (NSArray *)arrayWithMemberIsOnly:(NSArray *)array
//{
//    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
//    for (unsigned i = 0; i < [array count]; i++) {
//        @autoreleasepool {
//            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO) {
//                [categoryArray addObject:[array objectAtIndex:i]];
//            }
//        }
//    }
//    return categoryArray;
//}
//data 与数组，字典之间的转化
- (void)arr_data
{
    //    NSArray *arr1 = [[NSArray alloc]initWithObjects:@"0",@"5",nil];
    
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr1];
    
    //    NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

//排序
- (void)arrList
{
    //    _saishiAllTableView.arrData = (NSMutableArray *)[_saishiAllTableView.arrData sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    //        ZBLiveScoreModel *model1 = obj1;
    //        ZBLiveScoreModel *model2 = obj2;
    //        return[model1.sort compare:model2.sort options:NSNumericSearch];
    //    }];
    
}

//计算单行文字的长度和宽度
- (void)strSize
{
    //    CGSize size = [home sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font13,NSFontAttributeName, nil]];
    
}
//计算单行文字的长度和宽度
+ (CGFloat)getTextWidthSize:(NSString *)home strfont:(UIFont *)fontNum
{
    CGSize size = [home sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fontNum,NSFontAttributeName, nil]];
    
    
    return size.width;
}
//一段文字的长度和高度
+ (CGFloat)getTextHeightStationWidth:(NSString *)string anWidthTxtt:(CGFloat)widthText anfont:(CGFloat)fontSize andLineSpace:(CGFloat)linespace andHeaderIndent:(CGFloat)indent
{
    
    if (string == nil) {
        string= @"";
    }
    UIFont * tfont = [UIFont systemFontOfSize:fontSize + 0];
    
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    
    CGSize size =CGSizeMake(widthText,CGFLOAT_MAX);
    
    //    获取当前文本的属性
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    [paragraphStyle setLineSpacing:linespace];
    //首行空两个字的距离
    //    [paragraphStyle setFirstLineHeadIndent:indent];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    
    return actualsize.height;
    
}

+ (NSMutableAttributedString *)setTextStyleWithString:(NSString *)str WithLineSpace:(CGFloat)linespace WithHeaderIndent:(CGFloat)indet
{
    
    if (str == nil) {
        str = @"";
    }
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:linespace];
    //    [paragraphStyle1 setFirstLineHeadIndent:indet];
    [paragraphStyle1 setLineBreakMode:NSLineBreakByTruncatingTail | NSLineBreakByWordWrapping];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    return attributedString1;
}

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//输入的日期字符串形如：@"1992-05-21 13:08:08"

+ (NSDate *)getDateFromString:(NSString *)dateString byformat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

+ (UIColor *)getColor:(NSString *)hexColor
{
    if (hexColor == nil || [hexColor isEqualToString:@""]) {
        
        return color74;
    }else{
        
        if (hexColor.length>6) {
            if ([[hexColor substringToIndex:1] isEqualToString:@"#"]) {
                hexColor = [hexColor substringWithRange:NSMakeRange(1, 6)];
            }
            
            unsigned int red,green,blue;
            NSRange range;
            range.length = 2;
            
            range.location = 0;
            
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
            
            range.location = 2;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
            
            range.location = 4;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
            
            return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
            

        }
           }
    return color74;
    
}

+ (NSString *)md5WithString:(NSString *)str
{
    const char *str_C = [str UTF8String];
    unsigned char result[16];
    //    MD5加密
    CC_MD5(str_C, strlen(str_C), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    return nil;
}

+ (ZBUserModel *)getUserModel
{
    
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];

    
    ZBUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsPath stringByAppendingPathComponent:@"user.plist"]];
    return model;
}

+ (void)updateUsetModel:(ZBUserModel *)model
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];

    [NSKeyedArchiver archiveRootObject:model toFile:[documentsPath  stringByAppendingPathComponent:@"user.plist"]];
    
}

+ (ZBTokenModel *)getTokenModel
{
    
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    
    
    ZBTokenModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsPath stringByAppendingPathComponent:@"token.plist"]];
    return model;
}
+ (void)updateTokentModel:(ZBTokenModel *)model
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    
    [NSKeyedArchiver archiveRootObject:model toFile:[documentsPath  stringByAppendingPathComponent:@"token.plist"]];
    
}


+ (BOOL)login
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:islogin]) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"thirdPartLogin"]) {
            
            NSDate *now = [NSDate date];
            NSDate *thirdPartLoginDeadline = [ZBMethods getDateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"thirdPartLoginDeadline"] byformat:dateStyleFormatter];
            if ([now laterDate:thirdPartLoginDeadline] == now) {
                //第三方登陆过期了
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:islogin];
                return NO;
            }
            //第三方登录还没有过期
            return YES;
            
        }else{
            //不是第三方登陆
            return YES;
        }
    }else{
        //没有登录
        return NO;
    }
}
+ (void)toLogin
{
    ZBLoginViewController *loginVC = [[ZBLoginViewController alloc] init];
    loginVC.type = typeLoginNormal;
    [APPDELEGATE.customTabbar presentToViewController:loginVC animated:YES completion:^{
        
    }];
}
//给lab上的不同的字表明不同的颜色
- (void)labTextColor
{
    UILabel* noteLabel = [[UILabel alloc] init];
    noteLabel.frame = CGRectMake(60, 100, 200, 100);
    noteLabel.textColor = [UIColor blackColor];
    noteLabel.numberOfLines = 2;
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"点击注册按钮,即表示您已同意隐私条款和服务协议"];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"注册"].location, [[noteStr string] rangeOfString:@"注册"].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    
    NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:@"同意"].location, [[noteStr string] rangeOfString:@"同意"].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:redRangeTwo];
    
    [noteLabel setAttributedText:noteStr];
    [noteLabel sizeToFit];
    //    [self.view addSubview:noteLabel];
    
}



+ (NSMutableAttributedString *)withContent:(NSString *)content contentColor:(UIColor *)contentColor WithColorText:(NSString *)text textColor:(UIColor *)textColor
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:text].location, [[noteStr string] rangeOfString:text].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:textColor range:redRange];
    return noteStr;
}
+ (NSMutableAttributedString *)withContent:(NSString *)content  WithColorText:(NSString *)text  textColor:(UIColor *)textColor strFont:(UIFont *)stringfont
{
    NSLog(@"content ---%@ text ---%@",content,text);
//    if (isNUll(content) || isNUll(text)) {
//        return (NSMutableAttributedString *)content;
//    }
    if (content==nil||[content isEqualToString:@"(null)"]) {
        content=@"";
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:text].location, [[noteStr string] rangeOfString:text].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:textColor range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:stringfont range:redRange];
    
    return noteStr;
}
+ (NSMutableAttributedString *)withContent:(NSString *)content
                             WithContColor:(UIColor *)ContentColor
                           WithContentFont:(UIFont *)contentFont
                                  WithText:(NSString *)text
                             WithTextColor:(UIColor *)textColor
                              WithTextFont:(UIFont *)textFont
{
    
    NSLog(@"content ---%@ text ---%@",content,text);
//    if (isNUll(content) || isNUll(text)) {
//        return (NSMutableAttributedString *)content;
//    }

    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:content];
    [noteStr addAttribute:NSForegroundColorAttributeName value:ContentColor range:NSMakeRange(0, noteStr.length)];
    [noteStr addAttribute:NSFontAttributeName value:contentFont range:NSMakeRange(0, noteStr.length)];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:text].location, [[noteStr string] rangeOfString:text].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:textColor range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:textFont range:redRange];

    return noteStr;
}

//一半的圆角
- (void)halfCorner
{
    UIView *viewColor1 = [[UIView alloc] init];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:viewColor1.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(viewColor1.height/2, viewColor1.height/2)];
    CAShapeLayer *layer1 = [[CAShapeLayer alloc] init];
    layer1.frame = viewColor1.bounds;
    layer1.path = path1.CGPath;
    viewColor1.layer.mask = layer1;
    
}
//文／bestswifter（简书作者）
//原文链接：http://www.jianshu.com/p/f970872fdc22
//著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。

//func kt_drawRectWithRoundedCorner(radius radius: CGFloat,
//                                  borderWidth: CGFloat,
//                                  backgroundColor: UIColor,
//                                  borderColor: UIColor) -> UIImage {
//    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.mainScreen().scale)
//    let context = UIGraphicsGetCurrentContext()
//
//    CGContextMoveToPoint(context, 开始位置);  // 开始坐标右边开始
//    CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//    let output = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return output
//}

//+ (UIImage *)drawRectWithRoundedCornerWithRadius:(CGFloat)radius withBorderWidth:(CGFloat)borderWidth WithBgcolor:(UIColor *)bgColor
//{
//    UIGraphicsBeginImageContextWithOptions(, false, <#CGFloat scale#>)
//    return nil;
//}


/*
 matchstate：比赛状态，（0:未开,1:上半场,2:中场,3:下半场,4,加时，-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场，-10取消）
 */
+ (NSString *)getTextByMatchState:(NSInteger)matchState
{
    switch (matchState) {
        case 0:
        {
            return @"vs";
        }
            break;
        case 1:
        {
            return @"比赛中";
        }
            break;
        case 2:
        {
            return @"比赛中";
        }
            break;
        case 3:
        {
            return @"比赛中";
        }
            break;
        case 4:
        {
            return @"比赛中";
        }
            break;
            
        case -11:
        {
            return @"待定";
        }
            break;
        case -12:
        {
            return @"腰斩";
        }
            break;
        case -13:
        {
            return @"终端";
        }
            break;
        case -14:
        {
            return @"推迟";
        }
            break;
        case -1:
        {
            return @"完场";
        }
            break;
        case -10:
        {
            return @"取消";
        }
            break;
            
        default:
            break;
    }
    return nil;
}


#pragma mark ----------permission:0：普通用户，1：普通情报员，2：高级情报员，4：普通推荐师，8：高级推荐师，16：普通新闻官，32：高级新闻官，63：全部权限
+ (BOOL)panduan:(NSInteger)mode permission:(NSInteger)permission{
    NSInteger tmp = permission & mode;
    if(tmp > 0){
        return YES;
    }
    return NO;
}

+ (UIImage *)captureImageFromView:(UIView *)view
{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


/*
 （1）Documents：应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
 （2）tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
 （3）Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 */

//清除缓存按钮的点击事件
- (void)putBuffer
{
    CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
    
    NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.2fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.2fK, 删除缓存", size * 1024.0];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        //        [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
        [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject];
        [self cleanCaches:NSTemporaryDirectory()];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
//    [self showDetailViewController:alert sender:nil];
}

// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}


// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
        
    }
}




+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/GQapp" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"GQapp"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    NSLog(@"%@",dstURL);
    return dstURL;
}



//截图功能

-(UIImage *)captureImageFromView:(UIView *)view

{
    
    //    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //
    //    [view.layer renderInContext:ctx];
    //
    //    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    //
    //    return image;
    
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = view.frame;
    //  自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates: 它允许你截取一个UIView或者其子类中的内容，并且以位图的形式（bitmap）保存到UIImage中
    [view drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}


//获取字符串的宽度
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:fontSize];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{
                                                                                                                                              NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                              NSFontAttributeName:font
                                                                                                                                              } context:nil];
    
    return sizeToFit.size.width;
}
//获得字符串的高度
+ (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:18.0];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                             NSFontAttributeName:font
                                                                                                                                             } context:nil];
    return sizeToFit.size.height;
}

+ (UIImage *)defaultPlaceHolderImage:(NSString *)imageName {
    UIImage  *image = [UIImage imageNamed:imageName ? : @""];
    if (image == nil) {
//        image = [UIImage i];
    }
    return image;
}

+ (NSString *)formatHHSSStamp:(NSUInteger)timeStamp {
    timeStamp = timeStamp;
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"HH:mm"];
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *timeText = [stampFormatter stringFromDate:stampDate];
    return timeText;
}

+ (NSUInteger)formatTimeStr:(NSString *)timeStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *lastDate = [formatter dateFromString:timeStr];
    long long firstStamp = (long long)[lastDate timeIntervalSince1970] * 1000;
    return firstStamp;
}


+ (NSString *)formatMMDDWithStamp:(NSUInteger)timeStamp {
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [stampFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *timeText = [stampFormatter stringFromDate:stampDate];
    return timeText;
}

+ (NSString *)compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval: interval];
    NSDate *nowDate =[[NSDate date] dateByAddingTimeInterval: interval];
    // 两个时间间隔
    NSTimeInterval timeInterval= [mydate timeIntervalSinceDate:nowDate];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    } else if((temp = timeInterval/(60*60)) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else if((temp = timeInterval/(246060)) <30){
        result = [self getDateByStyle:@"MM-dd HH:mm" withDate:timeDate];
    }  else{
       result = [self getDateByStyle:@"MM-dd HH:mm" withDate:timeDate];
    }
    return result;
    
}

+ (NSInteger)amountWithProductId:(NSString *)productId {
    NSInteger amount = 0;
    if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian8"]) {
        amount = 8;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian18"]) {
        amount = 18;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian28"]) {
        amount = 28;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian38"]) {
        amount = 38;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian68"]) {
        amount = 68;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian88"]) {
        amount = 88;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapptuijian188"]) {
        amount = 188;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapp.mx18"]) {
        amount = 18;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapp.moxing188"]) {
        amount = 188;
    } else if ([productId isEqualToString:@"com.Gunqiu.GQapp.moxing618"]) {
        amount = 618;
    }
    return amount;
}
+ (NSString*)iphoneType {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return @"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return @"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}

+ (NSString *)amountFormater:(NSString *)amountValue {
    NSInteger value = [amountValue integerValue];
    CGFloat floatValue = value / 100.f;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *amount = [formatter stringFromNumber:[NSNumber numberWithDouble:floatValue]];
    NSInteger point = [amount rangeOfString:@"."].location;
    if (point == NSNotFound) {
        amount = [amount stringByAppendingString:@".00"];
    }
    if (point != NSNotFound) {
        NSString *afterPoint = [amount substringFromIndex:point];
        if (afterPoint.length == 2) {
            amount = [amount stringByAppendingString:@"0"];
        }
    }
    return amount;
}

// 获取当前跟视图
+ (UIViewController *)help_getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

+ (NSString *)getPersonLeavelImageName:(NSInteger)leavel {
    NSString *imageName = @"";
    if (leavel == 0) {
        imageName = @"";
    } else if (leavel == 1) {
        imageName = @"leavel0";
    } else if (leavel == 2) {
        imageName = @"leavel1";
    } else if (leavel == 3) {
        imageName = @"leavel2";
    } else if (leavel == 4) {
        imageName = @"leavel3";
    } else if (leavel == 5) {
        imageName = @"leavel4";
    } else if (leavel == 6) {
        imageName = @"leavel5";
    } else if (leavel == 7) {
        imageName = @"leavel6";
    }
    return imageName;
}


@end
















