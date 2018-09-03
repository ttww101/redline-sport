//
//  ZBMedalsModel.m
//  GQapp
//
//  Created by WQ on 16/10/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBMedalsModel.h"

@implementation ZBMedalsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"url" : @"url",
             @"number" : @"number",
             };
}
@end
