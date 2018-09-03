//
//  TouZhuModel.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "TouZhuModel.h"

@implementation TouZhuModel
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
