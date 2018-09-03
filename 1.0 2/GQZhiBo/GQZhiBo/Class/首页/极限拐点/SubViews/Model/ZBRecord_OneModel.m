#import "ZBRecord_OneModel.h"
@implementation ZBRecord_OneModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"teamid":@"teamid",
             @"teamname" : @"teamname",
             @"result" : @"result",
             @"mtime":@"mtime",
             @"league":@"league",
             @"hometeam":@"hometeam",
             @"guestteam" : @"guestteam",
             @"win" : @"win",
             @"draw":@"draw",
             @"lost":@"lost",
             @"lose":@"lose",
             @"sort":@"sort",
             @"zou":@"zou",
             @"mostresult":@"mostresult",
             @"historymostresult":@"historymostresult",
             @"type":@"type",
             @"sortone" : @"sortone",
             };
}
@end
