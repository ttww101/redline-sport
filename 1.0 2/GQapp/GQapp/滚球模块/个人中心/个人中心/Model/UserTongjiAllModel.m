//
//  UserTongjiAllModel.m
//  GQapp
//
//  Created by WQ on 2017/8/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "UserTongjiAllModel.h"

@implementation UserTongjiAllModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"month" : @"month",
             @"all" : @"all",
             @"week" : @"week",
             @"recent" : @"recent",
             
             };
}

+ (NSValueTransformer *)monthJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserTongjiModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserTongjiModel class]];
}
+ (NSValueTransformer *)weekJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserTongjiModel class]];
}
@end
