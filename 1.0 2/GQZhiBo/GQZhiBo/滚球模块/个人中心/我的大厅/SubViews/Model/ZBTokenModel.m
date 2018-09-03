#import "ZBTokenModel.h"
@implementation ZBTokenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"refreshToken" : @"refreshToken",
             @"token" : @"token",
             };
}
@end
