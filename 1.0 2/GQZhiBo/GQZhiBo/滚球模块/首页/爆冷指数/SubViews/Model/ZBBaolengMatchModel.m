//
//  ZBBaolengMatchModel.m
//  GQapp
//
//  Created by WQ on 2017/8/9.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBaolengMatchModel.h"

@implementation ZBBaolengMatchModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"matchtime" : @"matchtime",
             @"FirstGuestWin" : @"FirstGuestWin",
             @"FirstHomeWin" : @"FirstHomeWin",
             @"homescore" : @"homescore",
             @"guestscore" : @"guestscore",
             @"FirstStandoff" : @"FirstStandoff",
             @"mid" : @"mid",
             @"league" : @"league",
             @"hometeam" : @"hometeam",
             @"kind" : @"kind",
             @"guestteam" : @"guestteam",
             };
}
@end
