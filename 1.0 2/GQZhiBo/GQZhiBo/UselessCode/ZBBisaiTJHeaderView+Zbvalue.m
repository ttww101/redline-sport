#import "ZBBisaiTJHeaderView+Zbvalue.h"
@implementation ZBBisaiTJHeaderView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)setArrdataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}

@end
