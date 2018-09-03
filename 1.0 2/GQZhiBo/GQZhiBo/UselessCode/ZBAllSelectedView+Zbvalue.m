#import "ZBAllSelectedView+Zbvalue.h"
@implementation ZBAllSelectedView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)viewLineZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)viewCenterZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)btnAllZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)btnNotAllZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)btnConfirmZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)btnClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)changeBtnSelectedStateZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}

@end
