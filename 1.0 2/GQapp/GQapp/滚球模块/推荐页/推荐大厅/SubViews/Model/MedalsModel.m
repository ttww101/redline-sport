//
//  MedalsModel.m
//  GQapp
//
//  Created by WQ on 16/10/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "MedalsModel.h"

@implementation MedalsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"url" : @"url",
             @"number" : @"number",
             };
}
@end
