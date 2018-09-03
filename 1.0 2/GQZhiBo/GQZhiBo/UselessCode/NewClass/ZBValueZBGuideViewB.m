#import "ZBValueZBGuideViewB.h"
@implementation ZBValueZBGuideViewB
+ (BOOL)CInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)FscrollView:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)qtoTabBar:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}

@end
