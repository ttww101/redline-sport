//
//  LiveEventMedel.m
//  GQapp
//
//  Created by WQ_h on 16/5/4.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "LiveEventMedel.h"

@implementation LiveEventMedel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"teamid" : @"teamid",
             @"name" : @"name",
             @"type" : @"type",
             @"ishome" : @"ishome",
             };
}
@end
