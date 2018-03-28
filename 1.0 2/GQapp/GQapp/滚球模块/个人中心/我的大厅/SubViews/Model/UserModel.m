//
//  UserModel.m
//  GQapp
//
//  Created by WQ_h on 16/3/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "UserModel.h"
#import "MedalsModel.h"
@implementation UserModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
    @"avaliable" : @"avaliable",
    @"createTime" : @"createTime",
    @"extension1" : @"extension1",
    @"focusCount" : @"focusCount",
    @"followerCount" : @"followerCount",
    @"idId" : @"id",
    @"infoCount" : @"infoCount",
    @"ip" : @"ip",
    @"levelId" : @"levelId",
    @"mobile" : @"mobile",
    @"nickname" : @"nickname",
    @"password" : @"password",
    @"pic" : @"pic",
    @"profitRate" : @"profitRate",
    @"recommendCount" : @"recommendCount",
    @"resource" : @"resource",
    @"roleId" : @"roleId",
    @"username" : @"username",
    @"winRate" : @"winRate",
    @"focused" : @"focused",
    @"cnickid" : @"cnickid",
    @"userinfo" : @"userinfo",
    @"usertitle" : @"usertitle",
    @"mode":@"mode",
    @"medals" : @"medals",
    @"analyst":@"analyst",
    @"autonym":@"autonym",
    @"qq":@"qq",
    @"wechat":@"wechat",
    @"applyreason":@"applyreason",
    @"realname":@"realname",
    @"cardid":@"cardid",
    @"skill":@"skill",
    @"failreason":@"failreason",
    @"remarkContinuous" : @"remarkContinuous",
    @"remarkWinNum" : @"remarkWinNum",
    @"refreshToken" : @"refreshToken",
    @"token" : @"token",
    @"balance" : @"balance",
    @"reachLimit" : @"reachLimit",
    @"showmobile" : @"showmobile",

    };
}
//+ (NSValueTransformer *)idIdJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
//        return [NSString stringWithFormat:@"%@",number];
//    }];
//}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[MedalsModel class]];
    
}

@end
