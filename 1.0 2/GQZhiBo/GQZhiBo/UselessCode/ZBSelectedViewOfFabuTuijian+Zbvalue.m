#import "ZBSelectedViewOfFabuTuijian+Zbvalue.h"
@implementation ZBSelectedViewOfFabuTuijian (Zbvalue)
+ (BOOL)setCurrentIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)labCompanyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)btnWinZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)btnPingZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)btnLoseZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)choiceTypeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}
+ (BOOL)clearbackGroundImageZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}

@end
