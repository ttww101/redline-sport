#import "ZBShowActivityView+Zbvalue.h"
@implementation ZBShowActivityView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)configUIZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}

@end
