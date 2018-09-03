//
//  DateValueFormatter.m
//  无限滚动
//
//  Created by caoting on 2016/11/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DateValueFormatter.h"

@interface DateValueFormatter()
{
    NSArray * _arr;
}
@end
@implementation DateValueFormatter
-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    if (value<0) {
        return @"";
    }
    if ((NSInteger)value >_arr.count-1) {
        return @"";

    }
    
    return _arr[(NSInteger)value];
}


@end
