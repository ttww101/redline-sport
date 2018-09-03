#import "CouponListModel+Zbvalue.h"
@implementation CouponListModel (Zbvalue)
+ (BOOL)modelContainerPropertyGenericClassZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}

@end
