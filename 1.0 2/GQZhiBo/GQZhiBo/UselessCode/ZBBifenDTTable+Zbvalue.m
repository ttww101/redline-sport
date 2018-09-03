#import "ZBBifenDTTable+Zbvalue.h"
@implementation ZBBifenDTTable (Zbvalue)
+ (BOOL)gestureRecognizerShouldrecognizesimultaneouslywithgesturerecognizerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}

@end
