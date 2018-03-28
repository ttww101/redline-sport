//
//  PriceListModel.m
//  GQapp
//
//  Created by WQ on 2017/7/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "PriceListModel.h"

@implementation PriceListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"amount" : @"amount" ,
             @"desc" : @"desc" ,
            };
}
@end
