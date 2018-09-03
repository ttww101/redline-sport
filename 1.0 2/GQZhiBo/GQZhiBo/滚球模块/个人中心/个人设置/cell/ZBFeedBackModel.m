//
//  ZBFeedBackModel.m
//  GQapp
//
//  Created by Marjoice on 21/09/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBFeedBackModel.h"

@implementation ZBFeedBackModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"title" : @"title",
             @"content" : @"content",
             @"reply" : @"reply",
             };
}

@end
