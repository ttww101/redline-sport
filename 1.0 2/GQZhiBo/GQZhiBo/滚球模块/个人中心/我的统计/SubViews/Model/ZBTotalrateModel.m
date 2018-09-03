//
//  ZBTotalrateModel.m
//  GQapp
//
//  Created by WQ_h on 16/8/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBTotalrateModel.h"

@implementation ZBTotalrateModel
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"date" : @"date",
             @"profitRate" : @"profitRate",
             @"winRate" : @"winRate",
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"recommendCount" : @"recommendCount",
             @"winnum" : @"winnum",
             @"unitstr" : @"unitstr",
             
             };
}

@end
