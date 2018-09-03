#import "ZBPlycSelectedView+Zbvalue.h"
@implementation ZBPlycSelectedView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)btnselectedPlayZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)btnselectedTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)tapTouchZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}

@end
