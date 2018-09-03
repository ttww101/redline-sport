#import "ZBHeaderAmountView+Zbvalue.h"
@implementation ZBHeaderAmountView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)configUIZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)controlActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)myIncomeActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)myGiftZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)myGoldZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)myCouponZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)rechargeActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)lineViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)verticalViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)amauntLabelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)controlZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)buyBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)myIncomeBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)rechargeBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)rightArrorImageViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}

@end
