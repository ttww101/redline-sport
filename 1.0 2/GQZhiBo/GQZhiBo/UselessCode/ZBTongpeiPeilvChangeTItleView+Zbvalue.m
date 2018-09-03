#import "ZBTongpeiPeilvChangeTItleView+Zbvalue.h"
@implementation ZBTongpeiPeilvChangeTItleView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)labPeilvZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)labKailiZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)labBackRateZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)labTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
