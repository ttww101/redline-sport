#import "ZBUserTuiianView+Zbvalue.h"
@implementation ZBUserTuiianView (Zbvalue)
+ (BOOL)initZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)btnClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
