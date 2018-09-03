//
//  ZBDan_StringGuanModel.m
//  GQapp
//
//  Created by 叶忠阳 on 16/9/5.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBDan_StringGuanModel.h"

@implementation ZBDan_StringGuanModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"count" : @"count",
             @"index" : @"index",
             @"matchs":@"matchs",

             };
}

+ (NSValueTransformer *)matchsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBDan_StringMatchsModel class]];
    
}



@end
