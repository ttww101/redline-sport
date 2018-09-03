//
//  ZBRollInfoModel.m
//  GQapp
//
//  Created by WQ on 16/11/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBRollInfoModel.h"

@implementation ZBRollInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"idId" : @"id",
             @"match_id" : @"match_id",
             @"on_index_title" : @"on_index_title",
             
             };
}

@end
