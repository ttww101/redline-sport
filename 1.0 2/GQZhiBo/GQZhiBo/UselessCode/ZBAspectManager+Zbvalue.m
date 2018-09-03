#import "ZBAspectManager+Zbvalue.h"
@implementation ZBAspectManager (Zbvalue)
+ (BOOL)GQ_SavePageDicZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)GQ_PathForPageDicZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
