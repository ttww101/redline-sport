#import "ZBPlycPeilvView+Zbvalue.h"
@implementation ZBPlycPeilvView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)btnselectedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)taptouchZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}

@end
