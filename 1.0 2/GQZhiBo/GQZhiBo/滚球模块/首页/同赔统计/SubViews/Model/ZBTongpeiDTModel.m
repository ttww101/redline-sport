//
//  ZBTongpeiDTModel.m
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBTongpeiDTModel.h"

@implementation ZBTongpeiDTModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"same" : @"same",
             @"all" : @"all",
             };
}
+ (NSValueTransformer *)sameJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBTongpeiDetailModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBTongpeiDetailModel class]];
}
@end
