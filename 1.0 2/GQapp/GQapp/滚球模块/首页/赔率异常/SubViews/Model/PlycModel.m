//
//  PlycModel.m
//  GQapp
//
//  Created by WQ on 2017/9/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "PlycModel.h"

@implementation PlycModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"amp" : @"amp",
             @"companyId" : @"companyId",
             @"companyName" : @"companyName",
             @"drawAmp" : @"drawAmp",
             @"finalDraw" : @"finalDraw",
             @"finalLose" : @"finalLose",
             @"finalWin" : @"finalWin",
             @"firstDraw" : @"firstDraw",
             @"firstLose" : @"firstLose",
             @"guestTeam" : @"guestTeam",
             @"homeTeam" : @"homeTeam",
             @"idId" : @"id",
             @"loseAmp" : @"loseAmp",
             @"matchTime" : @"matchTime",
             @"matchType" : @"matchType",
             @"oddType" : @"oddType",
             @"scheduleId" : @"scheduleId",
             @"sclassName" : @"sclassName",
             @"statisTime" : @"statisTime",
             @"symbol" : @"symbol",
             @"timeType" : @"timeType",
             @"type" : @"type",
             @"winAmp" : @"winAmp",
             @"changeNum" : @"changeNum",
             @"panProcess" : @"panProcess",
             @"finalTime" : @"finalTime",
             @"firstTime" : @"firstTime",
             @"oddsId" : @"oddsId",
             @"finalTimeCn" : @"finalTimeCn",
             
             };
}

+ (NSValueTransformer *)panProcessJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[PanProcessModel class]];
    
}
@end
