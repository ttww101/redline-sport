//
//  StatisticsModel.m
//  GQapp
//
//  Created by WQ_h on 16/4/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#import "UsermarkModel.h"
#import "MedalsModel.h"

#import "StatisticsModel.h"
@implementation StatisticsModel
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
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodPlayModel class]];
}
+ (NSValueTransformer *)goodsclassJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsclassModel class]];
}
+ (NSValueTransformer *)RecoommandmodelJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TuijiandatingModel class]];
}


+ (NSValueTransformer *)arrTotalrateJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TotalrateModel class]];
    
}




+ (NSValueTransformer *)arrUsertitleJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[UsermarkModel class]];
    
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[MedalsModel class]];
    
}

@end
