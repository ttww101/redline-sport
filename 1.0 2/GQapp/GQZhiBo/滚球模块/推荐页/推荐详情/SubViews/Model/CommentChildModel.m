//
//  CommentChildModel.m
//  GQapp
//
//  Created by WQ on 16/10/26.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "CommentChildModel.h"

@implementation CommentChildModel
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
