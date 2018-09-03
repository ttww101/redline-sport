//
//  ZBBaolengDetailModel.m
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBaolengDetailModel.h"

@implementation ZBBaolengDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"body" : @"body" ,
             @"list" : @"list" ,
             };
}

+ (NSValueTransformer *)bodyJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBBaolengDTModel class]];
}
+ (NSValueTransformer *)listJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBBaolengMatchModel class]];
    
}

@end
