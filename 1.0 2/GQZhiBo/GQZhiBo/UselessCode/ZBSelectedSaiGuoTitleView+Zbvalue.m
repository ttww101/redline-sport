#import "ZBSelectedSaiGuoTitleView+Zbvalue.h"
@implementation ZBSelectedSaiGuoTitleView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)setArrDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)setDateIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)updateSubViewBeforeTwoZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)btnDateClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)btnLeftClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)btnRightClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}

@end
