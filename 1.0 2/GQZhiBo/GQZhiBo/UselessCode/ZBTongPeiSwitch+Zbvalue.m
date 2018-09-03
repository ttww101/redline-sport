#import "ZBTongPeiSwitch+Zbvalue.h"
@implementation ZBTongPeiSwitch (Zbvalue)
+ (BOOL)initZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)tap1TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)tap2TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)setSelectedIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
