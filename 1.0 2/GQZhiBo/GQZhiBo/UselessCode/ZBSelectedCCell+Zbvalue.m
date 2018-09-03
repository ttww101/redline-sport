#import "ZBSelectedCCell+Zbvalue.h"
@implementation ZBSelectedCCell (Zbvalue)
+ (BOOL)setCellSizeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)bgViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)labTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)labCountZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)bgSelectedViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)labSelectedTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)labSelectedCountZbvalue:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}

@end
