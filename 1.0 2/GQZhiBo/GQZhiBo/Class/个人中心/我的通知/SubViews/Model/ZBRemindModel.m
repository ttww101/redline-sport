#import "ZBRemindModel.h"
@implementation ZBRemindModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time" ,
             @"nickname" : @"nickname" ,
             @"mtime" : @"mtime" ,
             @"league" : @"league" ,
             @"hometeam" : @"hometeam" ,
             @"guestteam" : @"guestteam" ,
             @"mid" : @"mid" ,
             @"newsid" : @"newsid" ,
             @"iread" : @"iread" ,
             @"type" : @"type" ,
             };
}
@end
