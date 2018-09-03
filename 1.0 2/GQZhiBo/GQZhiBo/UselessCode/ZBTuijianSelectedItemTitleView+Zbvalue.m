#import "ZBTuijianSelectedItemTitleView+Zbvalue.h"
@implementation ZBTuijianSelectedItemTitleView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)tap1TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)tap2TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)tap3TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)tap4TapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)updateSelectedIndexWithindexWithtitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)attentionBtnSelectedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}

@end
