#import "ZBSucessViewOfSignatureView+Zbvalue.h"
@implementation ZBSucessViewOfSignatureView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)sucessBackZbvalue:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}
+ (BOOL)imgZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)labSuccZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)labContentZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)subAotoMasnaryZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}

@end
