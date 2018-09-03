//
//  ZBTechtwoModel.m
//  GQapp
//
//  Created by WQ on 2017/8/15.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBTechtwoModel.h"

@implementation ZBTechtwoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"shotsNum" : @"shotsNum",
             @"redCard" : @"redCard",
             @"shotsOn" : @"shotsOn",
             @"possessionTime" : @"possessionTime",
             @"shotsNotOn" : @"shotsNotOn",
             @"attacker" : @"attacker",
             @"attack" : @"attack",
             @"yellowCard" : @"yellowCard",
             @"cornerkick" : @"cornerkick",
             };
}
@end
