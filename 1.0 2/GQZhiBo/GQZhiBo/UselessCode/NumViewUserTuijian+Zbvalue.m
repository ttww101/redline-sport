#import "NumViewUserTuijian+Zbvalue.h"
@implementation NumViewUserTuijian (Zbvalue)
+ (BOOL)drawRectZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
