//
//  DxModel.m
//  GunQiuLive
//
//  Created by WQ_h on 16/3/10.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "DxModel.h"

@implementation DxModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"DownOdds" : @"downodds" ,
             @"Goal" : @"goal" ,
             @"UpOdds" : @"upodds" ,
             @"company" : @"company",
             @"odds":@"odds",
             @"homeDesc":@"homeDesc",
             @"guestDesc":@"guestDesc",
             };
}
//+ (NSValueTransformer *)GoalJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
//        return [NSString stringWithFormat:@"%.2f",[number floatValue]];
//        return nil;
//    }];
//}
+ (NSValueTransformer *)DownOddsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return (NSString *)[NSString stringWithFormat:@"%.2f",[number floatValue]];
        return nil;
    }];
}
+ (NSValueTransformer *)UpOddsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%.2f",[number floatValue]];
        return nil;
    }];
}

@end
