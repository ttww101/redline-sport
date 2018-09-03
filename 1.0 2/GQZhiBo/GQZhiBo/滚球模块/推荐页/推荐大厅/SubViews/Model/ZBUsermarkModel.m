//
//  ZBUsermarkModel.m
//  GQapp
//
//  Created by WQ on 16/10/9.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBUsermarkModel.h"

@implementation ZBUsermarkModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"createTime" : @"createTime",
             @"remark" : @"remark",
             @"type" : @"type",
             @"userId" : @"userId",
             @"isvalid" : @"isvalid",
             };
}
@end
