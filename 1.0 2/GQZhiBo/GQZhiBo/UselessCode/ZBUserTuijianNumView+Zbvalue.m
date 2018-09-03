#import "ZBUserTuijianNumView+Zbvalue.h"
@implementation ZBUserTuijianNumView (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
