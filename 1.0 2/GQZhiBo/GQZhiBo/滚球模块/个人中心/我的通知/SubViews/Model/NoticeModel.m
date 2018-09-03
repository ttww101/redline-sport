//
//  NoticeModel.m
//  GQapp
//
//  Created by WQ_h on 16/4/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"mid" : @"mid",
             @"title" : @"title",
             @"content" : @"content",
             @"iread" : @"iread",
             @"time" : @"time",
             };
}
@end
