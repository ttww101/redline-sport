#import "ZBBaolengSwitch+Zbvalue.h"
@implementation ZBBaolengSwitch (Zbvalue)
+ (BOOL)initZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)tap1TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)tap2TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)tap3TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)setSelectedIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}

@end
