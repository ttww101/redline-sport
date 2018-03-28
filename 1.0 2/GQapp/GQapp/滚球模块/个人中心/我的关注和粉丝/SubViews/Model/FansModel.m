//
//  FansModel.m
//  GQapp
//
//  Created by WQ_h on 16/3/31.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "FansModel.h"

@implementation FansModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"idId" : @"id",
             @"recommend_count" : @"recommend_count",
             @"nickname" : @"nickname",
             @"follower_count" : @"follower_count",
             @"info_count" : @"info_count",
             @"pic" : @"pic",
             @"focus_count" : @"focus_count",
             @"focused" : @"focused",
             };
}
@end
