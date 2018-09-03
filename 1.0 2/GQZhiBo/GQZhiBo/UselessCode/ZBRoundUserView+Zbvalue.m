#import "ZBRoundUserView+Zbvalue.h"
@implementation ZBRoundUserView (Zbvalue)
+ (BOOL)drawRectZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}

@end
