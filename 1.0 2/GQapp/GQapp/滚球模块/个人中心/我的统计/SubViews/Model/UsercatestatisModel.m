//
//  UsercatestatisModel.m
//  GQapp
//
//  Created by WQ on 2017/1/9.
//  Copyright © 2017年 GQXX. All rights reserved.
//
/*
 */
#import "UsercatestatisModel.h"

@implementation UsercatestatisModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"avgweeknum" : @"avgweeknum",
             @"userinfo" : @"userinfo",
             @"goodplay" : @"goodplay",
             @"goodsclass" : @"goodsclass",
             @"totalrate" : @"totalrate",
             @"nearten" : @"nearten",
             @"sclassStatis" : @"sclassStatis",
             @"playStatis0" : @"playAllStatis",
             @"playStatis1" : @"playOuStatis",
             @"playStatis2" : @"playYaStatis",
             @"playStatis3" : @"playDxStatis",
             @"yaPanStatis" : @"yaPanStatis",
             @"ouPanStatis" : @"ouPanStatis",
             @"dxPanStatis" : @"dxPanStatis",
             @"timeStatis" : @"timeStatis",
             @"monthGroup" : @"groupTimeMonthStatis",
             @"weekGroup" : @"groupTimeWeekStatis",
             };
}
+ (NSValueTransformer *)userinfoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StatisticsModel class]];
}
+ (NSValueTransformer *)goodplayJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodPlayModel class]];
}
+ (NSValueTransformer *)goodsclassJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsclassModel class]];
}

+ (NSValueTransformer *)totalrateJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TotalrateModel class]];
    
}
+ (NSValueTransformer *)sclassStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)playStatis0JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)playStatis1JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)playStatis2JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)playStatis3JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)yaPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)ouPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)dxPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)timeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)monthGroupJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)weekGroupJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
@end


















