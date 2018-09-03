#import "ZBBattleModel.h"
@implementation ZBBattleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"homename" : @"homename",
             @"guestname" : @"guestname",
             @"homenumber" : @"homenumber",
             @"guestnumber" : @"guestnumber",
             @"homeplayerid" : @"homeplayerid",
             };
}
@end
