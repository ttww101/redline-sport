#import "ZBUserTongjiView+Zbvalue.h"
@implementation ZBUserTongjiView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 29 == 0;
}
+ (BOOL)labWinRateZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)labWinRateTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)labProfiteZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)labProfiteTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)roundTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)roundNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)winTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)winNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)zouTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)zouNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)loseTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)loseNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)viewCenterZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)viewBottomZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)setautolayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}

@end
