//
//  BattleModel.m
//  GQapp
//
//  Created by Marjoice on 10/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "BattleModel.h"

@implementation BattleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"homename" : @"homename",
             @"guestname" : @"guestname",
             @"homenumber" : @"homenumber",
             @"guestnumber" : @"guestnumber",
             @"homeplayerid" : @"homeplayerid",
             };
}

@end
