//
//  ZBBaolengZishuModel.m
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBaolengZishuModel.h"

@implementation ZBBaolengZishuModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sort" : @"sort",
             @"sortone" : @"sortone",
             @"idId" : @"id",
             @"teamname" : @"teamname",
             @"mtime" : @"mtime",
             @"league" : @"league",
             @"hometeam" : @"hometeam",
             @"guestteam" : @"guestteam",
             @"mostresult" : @"mostresult",
             @"teamid" : @"teamid",
             @"win" : @"win",
             @"draw" : @"draw",
             @"lose" : @"lose",
             @"historyresult" : @"historyresult",
             @"num" : @"num",

            };
}
@end
