#import "ZBValueZBCouponModelB.h"
@implementation ZBValueZBCouponModelB
+ (BOOL)omodelCustomPropertyMapper:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}

@end
