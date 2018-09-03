#import "ZBValueZBBisaiTJRoundViewq.h"
@implementation ZBValueZBBisaiTJRoundViewq
+ (BOOL)iInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)FDrawrect:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}

@end
