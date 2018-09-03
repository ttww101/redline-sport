#import "ZBBisaiTJRoundView+Zbvalue.h"
@implementation ZBBisaiTJRoundView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)drawRectZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}

@end
