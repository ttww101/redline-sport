//
//  ZBUserlistModel.m
//  GQapp
//
//  Created by WQ on 16/11/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBUserlistModel.h"

@implementation ZBUserlistModel
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
