#import "ZBJSbifenModel.h"
@implementation ZBJSbifenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"data" : @"items",
             @"label" : @"label"
             };
}
+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBLiveScoreModel class]];
}
@end
