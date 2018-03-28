//
//  NewslistModel.m
//  GQapp
//
//  Created by WQ on 16/11/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "NewslistModel.h"

@implementation NewslistModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"commentcount" : @"commentcount",
             @"content" : @"content",
             @"createtime" : @"createtime",
             @"guestteam" : @"guestteam",
             @"hometeam" : @"hometeam",
             @"Idid" : @"id",
             @"itop" : @"itop",
             @"label" : @"label",
             @"league" : @"league",
             @"mtime" : @"mtime",
             @"nickname" : @"nickname",
             @"pic" : @"pic",
             @"pics" : @"pics",
             @"remark" : @"remark",
             @"thumb1" : @"thumb1",
             @"thumb2" : @"thumb2",
             @"thumb3" : @"thumb3",
             @"time" : @"time",
             @"title" : @"title",
             @"type" : @"type",
             @"userid" : @"userid",
             @"userpic" : @"userpic",
             };
}
@end
