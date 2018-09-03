//
//  ZBTongPeiTJModel.m
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBTongPeiTJModel.h"

@implementation ZBTongPeiTJModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"scheduleId" : @"scheduleId",
             @"symbol" : @"symbol",
             @"sclassId" : @"sclassId",
             @"sclassName" : @"sclassName",
             @"sclassColor" : @"sclassColor",
             @"matchTime" : @"matchTime",
             @"homeTeam" : @"homeTeam",
             @"guestTeam" : @"guestTeam",
             @"company" : @"company",
             @"win" : @"win",
             @"draw" : @"draw",
             @"lose" : @"lose",
             @"rate" : @"rate",
             @"rateDesc" : @"rateDesc",
             @"resultColor" : @"resultColor",
             @"num" : @"num",

             };
}
@end
