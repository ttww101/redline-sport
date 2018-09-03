#import "ZBTechtwoModel.h"
@implementation ZBTechtwoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"shotsNum" : @"shotsNum",
             @"redCard" : @"redCard",
             @"shotsOn" : @"shotsOn",
             @"possessionTime" : @"possessionTime",
             @"shotsNotOn" : @"shotsNotOn",
             @"attacker" : @"attacker",
             @"attack" : @"attack",
             @"yellowCard" : @"yellowCard",
             @"cornerkick" : @"cornerkick",
             };
}
@end
