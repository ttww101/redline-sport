#import "ZBCouponModel.h"
@implementation ZBCouponModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"couponID" : @"id"
             };
}
@end
@implementation CouponListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"ZBCouponModel") };
}
@end
