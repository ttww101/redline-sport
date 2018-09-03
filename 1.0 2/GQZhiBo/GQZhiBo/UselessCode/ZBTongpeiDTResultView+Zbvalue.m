#import "ZBTongpeiDTResultView+Zbvalue.h"
@implementation ZBTongpeiDTResultView (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}

@end
