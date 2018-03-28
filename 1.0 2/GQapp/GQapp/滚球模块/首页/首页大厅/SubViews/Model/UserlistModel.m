//
//  UserlistModel.m
//  GQapp
//
//  Created by WQ on 16/11/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "UserlistModel.h"

@implementation UserlistModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"nickname" : @"nickname",
             @"pic" : @"pic",
             @"remark" : @"remark",
             @"userid" : @"id",
             @"userintro" : @"userintro",
             @"newRecommendCount" : @"newRecommendCount",

             
             };
}
@end
