#import "ZBValueZBTuijianSelectedItemTitleViewp.h"
@implementation ZBValueZBTuijianSelectedItemTitleViewp
+ (BOOL)JInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)xtap1Tap:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)Wtap2Tap:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)Ptap3Tap:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)xtap4Tap:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)hUpdateselectedindexwithindextWithtitle:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)hAttentionbtnselected:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
