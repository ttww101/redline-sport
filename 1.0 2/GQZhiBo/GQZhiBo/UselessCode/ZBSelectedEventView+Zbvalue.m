#import "ZBSelectedEventView+Zbvalue.h"
@implementation ZBSelectedEventView (Zbvalue)
+ (BOOL)updateSelectedIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)viewPageZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)setArrDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)updateSelectedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)setAttentionNumZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}

@end
