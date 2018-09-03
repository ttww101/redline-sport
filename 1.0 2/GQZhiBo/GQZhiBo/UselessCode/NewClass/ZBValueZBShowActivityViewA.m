#import "ZBValueZBShowActivityViewA.h"
@implementation ZBValueZBShowActivityViewA
+ (BOOL)WInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)GconfigUI:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}

@end
