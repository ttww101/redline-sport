//
//  GoodsclassModel.m
//  GQapp
//
//  Created by WQ_h on 16/8/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "GoodsclassModel.h"

@implementation GoodsclassModel
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sclasscolor" : @"sclasscolor",
             @"sclassname" : @"sclassname",
             @"profitRate" : @"profitRate",
             @"winRate" : @"winRate",
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"recommendCount" : @"recommendCount",
             @"sclassid" : @"sclassid",
             @"winnum" : @"winnum",
             
             };
}

@end
