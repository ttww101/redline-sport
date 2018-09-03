#import "ZBNoticeModel.h"
@implementation ZBNoticeModel
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
