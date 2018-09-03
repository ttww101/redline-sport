//
//  ZBTokenModel.m
//  GQapp
//
//  Created by Marjoice on 13/09/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBTokenModel.h"

@implementation ZBTokenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"refreshToken" : @"refreshToken",
             @"token" : @"token",
             
             };
}

@end
