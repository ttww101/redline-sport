//
//  StatisticsSectionTwoModel.m
//  GQapp
//
//  Created by WQ_h on 16/8/16.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "StatisticsSectionTwoModel.h"

@implementation StatisticsSectionTwoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"playtype" : @"playtype",
             @"recommendCount" : @"recommendCount",
             @"type" : @"type",
             @"userid" : @"userid",
             @"winnum" : @"winnum",
             @"winRate" : @"winRate",
             @"profitRate" : @"profitRate",
             @"paninv" : @"paninv",
             @"playname" : @"playname",
             @"sclasscolor" : @"sclasscolor",
             @"sclassname" : @"sclassname",
             @"sclassid" : @"sclassid",
             @"timeinv" : @"timeinv",
             @"unitstr" : @"unitstr",
             @"choicename" : @"choicename",

             };
}
@end
