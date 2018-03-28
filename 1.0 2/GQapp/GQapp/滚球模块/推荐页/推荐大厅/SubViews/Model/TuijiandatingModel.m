//
//  TuijiandatingModel.m
//  GQapp
//
//  Created by WQ_h on 16/8/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "TuijiandatingModel.h"
#import "UsermarkModel.h"
#import "MedalsModel.h"
#import "payUserModel.h"
@implementation TuijiandatingModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"GuestTeam" : @"GuestTeam",
             @"comment_count" : @"comment_count",
             @"Name_JS" : @"Name_JS",
             @"choice" : @"choice",
             @"nickname" : @"nickname",
             @"fans" : @"fans",
             @"win_rate" : @"win_rate",
             @"share_count" : @"share_count",
             @"HomeTeam" : @"HomeTeam",
             @"match_id" : @"match_id",
             @"share_weixin_count" : @"share_weixin_count",
             @"pic" : @"pic",
             @"MatchTime" : @"MatchTime",
             @"share_weibo_count" : @"share_weibo_count",
             @"idId" : @"id",
             @"content" : @"content",
             @"title" : @"title",
             @"profit_rate" : @"profit_rate",
             @"recommend_count" : @"recommend_count",
             @"like_count" : @"like_count",
             @"create_time" : @"create_time",
             @"user_id" : @"user_id",
             @"lotterySort" : @"lotterySort",
             @"follower_count" : @"follower_count",
             @"focus_count" : @"focus_count",
             @"info_count" : @"info_count",
             @"ya" : @"ya",
             @"spf" : @"spf",
             @"dx" : @"dx",
             @"focused" : @"focused",
             @"liked" : @"liked",
             @"result" : @"result",
             @"hate_count" : @"hate_count",
             @"hated" : @"hated",
             @"MatchState" : @"MatchState",
             @"GuestScore" : @"GuestScore",
             @"HomeScore" : @"HomeScore",
             @"multiple" : @"multiple",
             @"company" : @"company",
             @"usertitle" : @"usertitle",
             @"earn" : @"earn",
             @"arrUsermark" : @"usermark",
             @"medals" : @"medals",
             @"contentInfo" : @"contentInfo",
             @"leagueColor" : @"leagueColor",
             @"readCount" : @"readCount",
             @"dayRange" : @"dayRange",
             @"amount" : @"amount",
             @"oid" : @"oid",
             @"paytime" : @"paytime",
             @"paystatus" : @"paystatus",
             @"payUsers_count": @"payUsers_count",
             @"see": @"see",
             @"payUsers":@"payUsers",
             @"userinfo":@"userinfo",
             @"status":@"status",
             @"playtype":@"playtype",
             @"odds":@"odds",
             @"otype":@"otype",

             };
}


+ (NSValueTransformer *)arrUsermarkJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[UsermarkModel class]];
    
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[MedalsModel class]];
    
}
+ (NSValueTransformer *)payUsersJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[payUserModel class]];
    
}

@end
