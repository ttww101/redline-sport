#import "ZBTongpeiDTTitileView+Zbvalue.h"
@implementation ZBTongpeiDTTitileView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)setSubviewsZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}

@end
