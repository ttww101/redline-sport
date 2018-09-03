//
//  ZBRedDanModel.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/5.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBRedDanModel.h"

@implementation ZBRedDanModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"scheduleId" : @"scheduleId",
             
             @"homeTeam" : @"homeTeam",
             
             @"guestTeamId" : @"guestTeamId",
             
             @"choice" : @"choice",
             
             @"homescore" : @"homescore",
             
             @"newsId" : @"newsId",
             
             @"pic" : @"pic",
             
             @"winRate" : @"winRate",
             
             @"userId" : @"userId",
             
             @"guestscore" : @"guestscore",
             
             @"nickName" : @"nickName",
             
             @"matchTime" : @"matchTime",
             
             @"guestTeam" : @"guestTeam",
             
             @"play" : @"play",
             
             @"homeTeamId" : @"homeTeamId",
             
             @"usermark" : @"usermark",
             
             @"result" : @"result"
             
             };
}
@end
