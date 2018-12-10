#import "ZBCommentModel.h"
#import "ZBCommentChildModel.h"
@implementation ZBCommentModel
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
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBCommentChildModel class]];
}
@end

@implementation DetailGroupModel

@end

