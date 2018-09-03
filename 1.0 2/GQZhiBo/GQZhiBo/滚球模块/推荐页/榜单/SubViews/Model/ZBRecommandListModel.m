#import "ZBRecommandListModel.h"
#import "ZBMedalsModel.h"
@implementation ZBRecommandListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"casua" : @"casua",
             @"casuatwo":@"casuatwo",
             @"createtime" : @"createtime",
             @"datestr" : @"datestr",
             @"extension1" : @"extension1",
             @"extension2" : @"extension2",
             @"idId" : @"id",
             @"nickname" : @"nickname",
             @"play" : @"play",
             @"rank" : @"rank",
             @"ranktype" : @"ranktype",
             @"realnums" : @"realnums",
             @"sclassid" : @"sclassid",
             @"type" : @"type",
             @"userid" : @"userid",
             @"usertitle" : @"usertitle",
             @"medals" : @"medals",
             @"winNum" : @"winNum",
             @"goNum" : @"goNum",
             @"loseNum" : @"loseNum",
             };
}
+ (NSValueTransformer *)rankJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
        return nil;
    }];
}
+ (NSValueTransformer *)realnumsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
        return nil;
    }];
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBMedalsModel class]];
}
@end
