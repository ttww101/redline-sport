//
//  ZBLivingModel.m
//  GunQiuLive
//
//  Created by WQ_h on 16/2/24.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "ZBLivingModel.h"

@implementation ZBLivingModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code" : @"code",
             @"gsc" : @"gsc",
             @"guestRed" : @"guestRed",
             @"guestYellow" : @"guestYellow",
             @"half" : @"half",
             @"homeRed" : @"homeRed",
             @"homeYellow" : @"homeYellow",
             @"hsc" : @"hsc",
             @"sid" : @"sid",
             @"htime" : @"htime",
             };
}
@end
