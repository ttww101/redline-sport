#import "ZBMessageControl+Zbvalue.h"
@implementation ZBMessageControl (Zbvalue)
+ (BOOL)initWithFrameTitleAmountZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}

@end
