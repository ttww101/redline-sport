#import "ZBWithdrawalView+Zbvalue.h"
@implementation ZBWithdrawalView (Zbvalue)
+ (BOOL)initZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)setcontentWithDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)configUIZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)withdrawalActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)bgViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)titleLabelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)amountLabelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)desLabelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)ruleLabelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)withdrawalBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}

@end
