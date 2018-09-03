#import "ZBUserViewofMyBuyTuijian+Zbvalue.h"
@implementation ZBUserViewofMyBuyTuijian (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)imagePicZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)labNameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)labStateTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}
+ (BOOL)labStateZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)viewLineZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)addLayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}

@end
