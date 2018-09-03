#import "ZBUsermarkModel.h"
@implementation ZBUsermarkModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"createTime" : @"createTime",
             @"remark" : @"remark",
             @"type" : @"type",
             @"userId" : @"userId",
             @"isvalid" : @"isvalid",
             };
}
@end
