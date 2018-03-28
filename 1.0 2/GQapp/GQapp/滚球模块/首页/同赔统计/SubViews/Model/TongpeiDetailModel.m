//
//  TongpeiDetailModel.m
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "TongpeiDetailModel.h"

@implementation TongpeiDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"playType" : @"playType",
             @"company" : @"company",
             @"win" : @"win",
             @"draw" : @"draw",
             @"lose" : @"lose",
             @"matchNum" : @"matchNum",
             @"winRate" : @"winRate",
             @"drawRate" : @"drawRate",
             @"loseRate" : @"loseRate",
             @"winRateDesc" : @"winRateDesc",
             @"drawRateDesc" : @"drawRateDesc",
             @"loseRateDesc" : @"loseRateDesc",
             @"matchs" : @"matchs",
             @"homeTeam" : @"homeTeam",
             @"guestTeam" : @"guestTeam",

             };
}


+ (NSValueTransformer *)matchsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TongPeiMatchModel class]];
    
}
@end
