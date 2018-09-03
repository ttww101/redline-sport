#import "ZBFeedBackCell+Zbvalue.h"
@implementation ZBFeedBackCell (Zbvalue)
+ (BOOL)setFeedModeltmpZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)awakeFromNibZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)labTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)labDetailZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)labReCallZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)labReCallDetailZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)addCellAutoLayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}

@end
