//
//  BaolengDetailModel.m
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BaolengDetailModel.h"

@implementation BaolengDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"body" : @"body" ,
             @"list" : @"list" ,
             };
}

+ (NSValueTransformer *)bodyJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaolengDTModel class]];
}
+ (NSValueTransformer *)listJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[BaolengMatchModel class]];
    
}

@end
