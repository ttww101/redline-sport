#import "ZBValueZBBaolengSwitchG.h"
@implementation ZBValueZBBaolengSwitchG
+ (BOOL)Oinit:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)ltap1Tap:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)vtap2Tap:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)ctap3Tap:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)ESetselectedindex:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}

@end
