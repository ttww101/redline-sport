//
//  JSbifenModel.m
//  GQapp
//
//  Created by WQ on 2017/5/17.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "JSbifenModel.h"

@implementation JSbifenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"data" : @"data",
             };
}

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[LiveScoreModel class]];
    
}

@end
