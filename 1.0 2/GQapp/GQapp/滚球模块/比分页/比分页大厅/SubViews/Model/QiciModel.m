//
//  QiciModel.m
//  GunQiuLive
//
//  Created by WQ_h on 16/3/2.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "QiciModel.h"

@implementation QiciModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"iscurrent" : @"iscurrent",
             @"name" : @"name",
             @"date":@"date",
             @"week":@"week",
             @"time":@"time"
             };
}
+ (NSValueTransformer *)createTimeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[number doubleValue]];
        
        return [Methods getDateByStyle:dateStyleFormatter withDate:date];
    }];
    return nil;
}
+ (NSValueTransformer *)updateTimeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *nunber) {
        return [Methods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSince1970:[nunber doubleValue]]];
    }];
    return nil;
}
//+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
//{
//    return nil;
//}
@end
