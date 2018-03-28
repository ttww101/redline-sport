//
//  CacheObject.m
//  HuanCunDome
//
//  Created by 叶忠阳 on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//
//缓存，可以根据URL后面来的判断该 数据是否已经存在，第一次请求时，我们要取得当前的时间，有些数据是要一段时间就要删除的，有些数据是在一定的时间点删除的

#import "CacheObject.h"

#define Momory  [NSUserDefaults standardUserDefaults]

@interface  CacheObject()
@property (nonatomic, retain)NSString *urlKey;
@property (nonatomic, retain)NSMutableArray *arrKey;//保存所有的key
@property (nonatomic, retain)NSMutableArray *arrTwoHours;//保存只缓存2小时的地方的key

@end

@implementation CacheObject

- (NSMutableArray *)arrKey{
    if (!_arrKey) {
        _arrKey = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _arrKey;
}

#pragma mark ----------判断数据是否已经存在
+(id)judge_In_MemoryToUrlKey:(NSString *)urlKey{
    if ([self judgeDateTime] != [[Momory objectForKey:@"day"] integerValue]) {
        NSArray *arr = [Momory objectForKey:@"arrKey"];
        for (int i = 0 ; i < arr.count; i ++) {
            [self delete_Data_urlKey:arr[i]];
        }
    }
    if ([self judgeDateHouersTwo] - [[Momory objectForKey:[NSString stringWithFormat:@"%@Two",urlKey]] integerValue] >= 5 ) {
        NSArray *arr = [Momory objectForKey:@"arrKeyTwo"];
        for (int i = 0; i < arr.count; i ++ ) {
            if ([arr[i] isEqualToString:[NSString stringWithFormat:@"%@Two",urlKey]]) {

                [self delete_Data_urlKey:urlKey];
            }
        }
        
    }
    id data = [Momory objectForKey:urlKey];
    //    判读这条数据是否存在
    if (data) {
       return  [self getDataUrlKey:urlKey];//取数据
    }
    return nil;
}


#pragma mark ----------存储数据
+(void)storage_Memory_UrlKey:(NSString *)urlKey data:(id)Data hour:(NSInteger)hour{
    NSMutableArray *arrKey = [[NSMutableArray alloc] initWithArray:[Momory objectForKey:@"arrKey"]];
    [arrKey addObject:urlKey];
    NSArray *arr = [[NSArray alloc] initWithArray:arrKey];
    [Momory setObject:arr forKey:@"arrKey"];
    [Momory setObject:@([self judgeDateTime]) forKey:@"day"];
    if (hour == 5) {
        [Momory setObject:@([self judgeDateHouersTwo]) forKey:[NSString stringWithFormat:@"%@Two",urlKey]];
        NSMutableArray *arrKey = [[NSMutableArray alloc] initWithArray:[Momory objectForKey:@"arrKeyTwo"]];
        [arrKey addObject:[NSString stringWithFormat:@"%@Two",urlKey]];
        NSArray *arr = [[NSArray alloc] initWithArray:arrKey];
        [Momory setObject:arr forKey:@"arrKeyTwo"];
    }
    
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:Data options:NSJSONWritingPrettyPrinted error:nil];
    [Momory setObject:data forKey:urlKey];
}
#pragma mark ----------取数据
+ (id)getDataUrlKey:(NSString *)urlKey{
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[Momory objectForKey:urlKey]
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
   return jsonObject;
    
}
#pragma mark ----------删除数据
+ (void)delete_Data_urlKey:(NSString *)urlKey{
    [Momory removeObjectForKey:urlKey];
    
}
+(NSInteger)judgeDateTime{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger day = [dateComponent day];
    return day;
}
+ (NSInteger)judgeDateHouersTwo{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [dateComponent hour];
    return hour;
}


@end
