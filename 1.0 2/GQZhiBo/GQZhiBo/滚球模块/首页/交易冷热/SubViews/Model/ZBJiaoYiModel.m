//
//  ZBJiaoYiModel.m
//  GQapp
//
//  Created by 叶忠阳 on 16/6/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBJiaoYiModel.h"

@implementation ZBJiaoYiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"sort":@"sort",
             @"league" : @"league",
             @"mtime":@"mtime",
             @"type" : @"type",
             @"deal":@"deal",
             @"bifa":@"bifa",
             @"maxval":@"maxval",
             @"hometeam":@"hometeam",
             @"guestteam":@"guestteam",
             @"homescore":@"homescore",
             @"guestscore":@"guestscore",
             @"matchstate":@"matchstate"
             };
}

@end
