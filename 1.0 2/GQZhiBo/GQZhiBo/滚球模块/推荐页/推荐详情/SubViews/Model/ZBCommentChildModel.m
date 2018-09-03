//
//  ZBCommentChildModel.m
//  GQapp
//
//  Created by WQ on 16/10/26.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBCommentChildModel.h"

@implementation ZBCommentChildModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"content" : @"content",
             @"userid" : @"userid",
             @"nickname" : @"nickname",
             @"createtime" : @"createtime",
             @"toUserid" : @"toUserid",
             @"toUsername" : @"toUsername",
             @"Idid" : @"id",
             @"likeCount" : @"likeCount",
             @"ilike" : @"ilike",

             };
}

@end
