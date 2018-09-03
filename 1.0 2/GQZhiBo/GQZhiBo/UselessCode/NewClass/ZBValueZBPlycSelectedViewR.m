#import "ZBValueZBPlycSelectedViewR.h"
@implementation ZBValueZBPlycSelectedViewR
+ (BOOL)BInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)KBtnselectedplay:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)HBtnselectedtime:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)ntapTouch:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
