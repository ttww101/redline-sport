#import "ZBValueZBTongPeiSwitchZ.h"
@implementation ZBValueZBTongPeiSwitchZ
+ (BOOL)Qinit:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)Btap1Tap:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)Ttap2Tap:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)FSetselectedindex:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}

@end
