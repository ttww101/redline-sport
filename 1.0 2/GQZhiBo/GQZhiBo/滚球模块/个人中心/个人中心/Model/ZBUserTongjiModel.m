//
//  ZBUserTongjiModel.m
//  GQapp
//
//  Created by WQ on 2017/8/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBUserTongjiModel.h"

@implementation ZBUserTongjiModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"goNum" : @"goNum",
             @"goodPlays" : @"goodPlays",
             @"goodSclass" : @"goodSclass",
             @"groupTimeStatis" : @"groupTimeStatis",
             @"groupunit" : @"groupunit",
             @"loseNum" : @"loseNum",
             @"playType" : @"playType",
             @"profitRate" : @"profitRate",
             @"totalNum" : @"totalNum",
             @"type" : @"type",
             @"userId" : @"userId",
             @"winNum" : @"winNum",
             @"winRate" : @"winRate",
             };
}

+ (NSValueTransformer *)groupTimeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBTotalrateModel class]];
    
}
@end
