//
//  GoodPlayModel.m
//  GQapp
//
//  Created by WQ_h on 16/8/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "GoodPlayModel.h"

@implementation GoodPlayModel
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"playname" : @"playname",
             @"profitRate" : @"profitRate",
             @"winRate" : @"winRate",
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"recommendCount" : @"recommendCount",
             @"winnum" : @"winnum",

             };
}

@end
