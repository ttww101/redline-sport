#import "ZBJSbifenModel.h"
@implementation ZBJSbifenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"data" : @"data",
             };
}
+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBLiveScoreModel class]];
}
@end
