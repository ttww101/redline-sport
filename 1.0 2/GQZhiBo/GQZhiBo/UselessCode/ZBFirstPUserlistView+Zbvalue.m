#import "ZBFirstPUserlistView+Zbvalue.h"
@implementation ZBFirstPUserlistView (Zbvalue)
+ (BOOL)setArrDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)btntouchZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}

@end
