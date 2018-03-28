//
//  CommentModel.m
//  GunQiuLive
//
//  Created by WQ_h on 16/3/17.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "CommentModel.h"
#import "CommentChildModel.h"
@implementation CommentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"content" : @"content",
             @"Idid" : @"id",
             @"news_id" : @"news_id",
             @"nickname" : @"nickname",
             @"status" : @"status",
             @"createtime" : @"createtime",
             @"userid" : @"userid",
             @"userpic" : @"userpic",
             @"child" : @"child",
             @"likeCount" : @"likeCount",
             @"ilike" : @"ilike",

             };
}
+ (NSValueTransformer *)childJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[CommentChildModel class]];
    
}

@end
