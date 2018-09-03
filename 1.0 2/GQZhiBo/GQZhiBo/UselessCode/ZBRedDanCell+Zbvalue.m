#import "ZBRedDanCell+Zbvalue.h"
@implementation ZBRedDanCell (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)tapFPinfoZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)basImgViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)imgZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)imgPhoneZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)labNameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)labRedNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)labSLZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)labSLStrZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)BkViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)labSPFZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)labTypeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)lineViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}
+ (BOOL)labHomeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)labScroeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 29 == 0;
}
+ (BOOL)labGuesZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)labTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)setMasZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}

@end
