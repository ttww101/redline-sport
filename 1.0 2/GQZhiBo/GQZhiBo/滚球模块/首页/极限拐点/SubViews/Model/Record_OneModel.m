//
//  Record_OneModel.m
//  GQapp
//
//  Created by 叶忠阳 on 16/6/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "Record_OneModel.h"

@implementation Record_OneModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"teamid":@"teamid",
             @"teamname" : @"teamname",
             @"result" : @"result",
             @"mtime":@"mtime",
             @"league":@"league",
             @"hometeam":@"hometeam",
             @"guestteam" : @"guestteam",
             @"win" : @"win",
             @"draw":@"draw",
             @"lost":@"lost",
             @"lose":@"lose",
             @"sort":@"sort",
             @"zou":@"zou",
             @"mostresult":@"mostresult",
             @"historymostresult":@"historymostresult",
             @"type":@"type",
             @"sortone" : @"sortone",

             };
}
@end
