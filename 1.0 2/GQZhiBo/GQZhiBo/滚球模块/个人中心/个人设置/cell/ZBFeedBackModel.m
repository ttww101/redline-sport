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
