#import "ZBUsermarkModel.h"
#import "ZBMedalsModel.h"
#import "ZBStatisticsModel.h"
@implementation ZBStatisticsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"avgweeknum" : @"avgweeknum",
             @"focus_count" : @"focus_count",
             @"follower_count" : @"follower_count",
             @"gonum" : @"gonum",
             @"idId" : @"id",
             @"level_id" : @"level_id",
             @"losenum" : @"losenum",
             @"recommend_count" : @"recommend_count",
             @"role_id" : @"role_id",
             @"winnum" : @"winnum",
             @"profit_rate" : @"profit_rate",
             @"win_rate" : @"win_rate",
             @"goodPlay" : @"goodplay",
             @"goodsclass" : @"goodsclass",
             @"Recoommandmodel" : @"news",
             @"arrNearten" : @"nearten",
             @"arrTotalrate" : @"totalrate",
             @"nickname" : @"nickname",
             @"pic" : @"pic",
             @"userinfo" : @"userinfo",
             @"usertitle" : @"usertitle",
             @"arrUsertitle" : @"usertitle",
             @"medals" : @"medals",
             };
}
+ (NSValueTransformer *)goodPlayJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBGoodPlayModel class]];
}
+ (NSValueTransformer *)goodsclassJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBGoodsclassModel class]];
}
+ (NSValueTransformer *)RecoommandmodelJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBTuijiandatingModel class]];
}
+ (NSValueTransformer *)arrTotalrateJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBTotalrateModel class]];
}
+ (NSValueTransformer *)arrUsertitleJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBUsermarkModel class]];
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBMedalsModel class]];
}
@end
