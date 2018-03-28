//
//  BaolengDTModel.m
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BaolengDTModel.h"

@implementation BaolengDTModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"teamname" : @"teamname",
             @"sort" : @"sort",
             @"mtime" : @"mtime",
             @"sid" : @"sid",
             @"num" : @"num",
             @"anotherteamid" : @"anotherteamid",
             @"historyresult" : @"historyresult",
             @"idId" : @"id",
             @"kind" : @"kind",
             @"mostresult" : @"mostresult",
             @"statistime" : @"statistime",
             @"teamid" : @"teamid",
             @"hometeam" : @"hometeam",
             @"guestteam" : @"guestteam",
             };
}


@end
