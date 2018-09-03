#import "ZBHeaderControl+Zbvalue.h"
@implementation ZBHeaderControl (Zbvalue)
+ (BOOL)initWithFrameContentShowrightlineZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)setContentZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}

@end
