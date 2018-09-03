#import "ZBSelectedDateTitleView+Zbvalue.h"
@implementation ZBSelectedDateTitleView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)setArrDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)setDateIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)updateSubViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)btnLeftClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)btnRightClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
