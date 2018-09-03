#import "ZBSuccessfulView+Zbvalue.h"
@implementation ZBSuccessfulView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)tapClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)imgZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)labSuccZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)labContentZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)btnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)labContentTwoZbvalue:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}
+ (BOOL)subAotoMasnaryZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
