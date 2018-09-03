#import "ZBGoodPlayModel.h"
@implementation ZBGoodPlayModel
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"playname" : @"playname",
             @"profitRate" : @"profitRate",
             @"winRate" : @"winRate",
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"recommendCount" : @"recommendCount",
             @"winnum" : @"winnum",
             };
}
@end
