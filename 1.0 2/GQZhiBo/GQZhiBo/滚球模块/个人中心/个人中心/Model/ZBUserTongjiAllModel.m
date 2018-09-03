//
//  ZBUserTongjiAllModel.m
//  GQapp
//
//  Created by WQ on 2017/8/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBUserTongjiAllModel.h"

@implementation ZBUserTongjiAllModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"month" : @"month",
             @"all" : @"all",
             @"week" : @"week",
             @"recent" : @"recent",
             
             };
}

+ (NSValueTransformer *)monthJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBUserTongjiModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBUserTongjiModel class]];
}
+ (NSValueTransformer *)weekJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBUserTongjiModel class]];
}
@end
