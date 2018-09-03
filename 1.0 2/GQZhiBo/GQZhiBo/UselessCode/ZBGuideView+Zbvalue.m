#import "ZBGuideView+Zbvalue.h"
@implementation ZBGuideView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)scrollViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)toTabBarZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}

@end
