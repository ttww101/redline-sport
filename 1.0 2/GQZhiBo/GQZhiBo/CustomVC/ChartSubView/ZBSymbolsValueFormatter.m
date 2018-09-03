//
//  ZBSymbolsValueFormatter.m
//  无限滚动
//
//  Created by caoting on 2016/11/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ZBSymbolsValueFormatter.h"

@implementation ZBSymbolsValueFormatter
-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}
//返回y轴的数据
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    
    return [NSString stringWithFormat:@"%ld%%",(NSInteger)value];
}
@end
