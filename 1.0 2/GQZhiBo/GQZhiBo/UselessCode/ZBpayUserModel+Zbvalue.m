#import "ZBpayUserModel+Zbvalue.h"
@implementation ZBpayUserModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}

@end
