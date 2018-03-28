//
//  TongPeiMatchModel.m
//  GQapp
//
//  Created by WQ on 2017/8/9.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "TongPeiMatchModel.h"

@implementation TongPeiMatchModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sclassName" : @"sclassName",
             @"sclassColor" : @"sclassColor",
             @"matchTime" : @"matchTime",
             @"homeTeam" : @"homeTeam",
             @"guestTeam" : @"guestTeam",
             @"homeScore" : @"homeScore",
             @"guestScore" : @"guestScore",
             @"firstWin" : @"firstWin",
             @"firstDraw" : @"firstDraw",
             @"firstLose" : @"firstLose",
             @"finalWin" : @"finalWin",
             @"finalDraw" : @"finalDraw",
             @"finalLose" : @"finalLose",
             @"result" : @"result",
             @"resultColor" : @"resultColor",
             };
}
@end
