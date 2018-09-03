//
//  TongpeiDTModel.m
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "TongpeiDTModel.h"

@implementation TongpeiDTModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"same" : @"same",
             @"all" : @"all",
             };
}
+ (NSValueTransformer *)sameJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TongpeiDetailModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TongpeiDetailModel class]];
}
@end
