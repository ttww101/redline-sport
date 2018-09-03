#import "ZBFenXiHeaderBottomView+Zbvalue.h"
@implementation ZBFenXiHeaderBottomView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)iconTQZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)labTQZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)labTQNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)labPlaceZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)labAdressZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)addAutolayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
