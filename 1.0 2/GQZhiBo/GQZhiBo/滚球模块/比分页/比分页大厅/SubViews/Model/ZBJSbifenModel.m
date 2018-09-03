//
//  ZBJSbifenModel.m
//  GQapp
//
//  Created by WQ on 2017/5/17.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBJSbifenModel.h"

@implementation ZBJSbifenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"data" : @"data",
             };
}

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBLiveScoreModel class]];
    
}

@end
