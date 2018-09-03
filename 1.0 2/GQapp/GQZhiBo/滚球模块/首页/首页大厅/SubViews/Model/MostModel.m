//
//  MostModel.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/6.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "MostModel.h"

@implementation MostModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"league" : @"league",
             @"hometeam" : @"hometeam",
             @"guestteam" : @"guestteam",
             @"hometeamid" : @"hometeamid",
             @"guestteamid" : @"guestteamid",
             @"teamname" : @"teamname",
             @"mark":@"mark",
             @"historymostresult":@"historymostresult",
             @"mostresult":@"mostresult",
             @"type":@"type",
             @"sort":@"sort",
             @"name":@"name",
             @"maxname":@"maxname"
             };
}


@end
