//
//  LiveScoreModel.m
//  GunQiuLive
//
//  Created by WQ_h on 16/2/3.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "LiveScoreModel.h"

@implementation LiveScoreModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"color" : @"color",
             @"guestOrder" : @"guestOrder",
             @"guestRed" : @"guestRed",
             @"guestYellow" : @"guestYellow",
             @"guesthalfscore"  :@"guesthalfscore",
             @"guestscore" : @"guestscore",
             @"guestteam" : @"guestteam",
             @"guestteamid" : @"guestteamid",
             @"homeOrder" : @"homeOrder",
             @"homeRed" : @"homeRed",
             @"homeYellow" : @"homeYellow",
             @"homehalfscore" : @"homehalfscore",
             @"homescore" : @"homescore",
             @"hometeam" : @"hometeam",
             @"hometeamid" : @"hometeamid",
             @"league" : @"league",
             @"leagueId" : @"leagueId",
             @"location" : @"location",
             @"matchstate" : @"matchstate",
             @"matchtime" : @"matchtime",
             @"matchtime2" : @"matchtime2",
             @"mid" : @"mid",
             @"neutrality" : @"neutrality",
             @"season" : @"season",
             @"temperature" : @"temperature",
             @"weather" : @"weather",
             @"info" : @"info",
             @"recommand" : @"recommand",
             @"letgoal" : @"letgoal",
             @"total" : @"total",
             @"standard" : @"standard",
             @"sort" : @"sort",
             @"remark" : @"remark",             
             @"homeCorner" : @"homeCorner",
             @"guestCorner" : @"guestCorner",
             @"leagueColor" : @"leagueColor",
             @"weathericon" : @"weathericon",
             @"homeOrderNum" : @"homeOrderNum",
             @"guestOrderNum" : @"guestOrderNum",

             };
}

@end
