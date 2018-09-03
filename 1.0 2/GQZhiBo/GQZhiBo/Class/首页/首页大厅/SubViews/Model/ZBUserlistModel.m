#import "ZBUserlistModel.h"
@implementation ZBUserlistModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"nickname" : @"nickname",
             @"pic" : @"pic",
             @"remark" : @"remark",
             @"userid" : @"id",
             @"userintro" : @"userintro",
             @"newRecommendCount" : @"newRecommendCount",
             };
}
@end
