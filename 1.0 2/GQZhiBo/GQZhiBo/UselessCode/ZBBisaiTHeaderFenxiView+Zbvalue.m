#import "ZBBisaiTHeaderFenxiView+Zbvalue.h"
@implementation ZBBisaiTHeaderFenxiView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}

@end
