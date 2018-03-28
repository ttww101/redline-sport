//
//  PeiLvDetailModel.m
//  GQapp
//
//  Created by Marjoice on 09/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "PeiLvDetailModel.h"

@implementation PeiLvDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"HappenTime" : @"HappenTime",
             @"Score" : @"Score",
             @"HomeOdds" : @"HomeOdds",
             @"PanKou" : @"PanKou",
             @"AwayOdds" : @"AwayOdds",
             @"ModifyTime" : @"ModifyTime",
             @"IsClosed" : @"IsClosed",
             };
}
@end
