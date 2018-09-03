#import "ZBCouponModel+Zbvalue.h"
@implementation ZBCouponModel (Zbvalue)
+ (BOOL)modelCustomPropertyMapperZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}

@end
