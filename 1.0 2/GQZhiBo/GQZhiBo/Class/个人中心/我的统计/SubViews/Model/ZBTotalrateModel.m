#import "ZBTotalrateModel.h"
@implementation ZBTotalrateModel
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"date" : @"date",
             @"profitRate" : @"profitRate",
             @"winRate" : @"winRate",
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"recommendCount" : @"recommendCount",
             @"winnum" : @"winnum",
             @"unitstr" : @"unitstr",
             };
}
@end
