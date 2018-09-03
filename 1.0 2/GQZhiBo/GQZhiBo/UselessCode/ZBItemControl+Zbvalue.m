#import "ZBItemControl+Zbvalue.h"
@implementation ZBItemControl (Zbvalue)
+ (BOOL)initWithFrameImagenameTitleAmountZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}

@end
