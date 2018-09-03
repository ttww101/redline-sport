#import "ZBDCindexBtn+Zbvalue.h"
@implementation ZBDCindexBtn (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)touchTapZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)imgScrollZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)updateScrollFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)updateScrollBySelfFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)panActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)hideSelfZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}

@end
