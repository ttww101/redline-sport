#import "ZBNavigationModel.h"
@implementation ZBNavigationModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"hometeam" : @"hometeam",
             @"guestteam" : @"guestteam",
             @"hot" : @"hot",
             @"info_count" : @"info_count",
             @"league" : @"league",
             @"leagueColor" : @"leagueColor",
             @"leagueId" : @"leagueId",
             @"matchtime" : @"matchtime",
             @"mid" : @"mid",
             @"recommend_count" : @"recommend_count",
             };
}
@end
