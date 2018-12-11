#import "ZBUserModel.h"
#import "ZBMedalsModel.h"
@implementation ZBUserModel
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
    @"coin":@"coin",
    @"redpackage":@"redpackage",
    @"cardPic1": @"cardPic1",
    @"cardPic2": @"cardPic2"
    };
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBMedalsModel class]];
}
@end
