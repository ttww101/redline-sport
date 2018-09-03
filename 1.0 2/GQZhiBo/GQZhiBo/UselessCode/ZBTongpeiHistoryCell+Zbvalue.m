#import "ZBTongpeiHistoryCell+Zbvalue.h"
@implementation ZBTongpeiHistoryCell (Zbvalue)
+ (BOOL)awakeFromNibZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)setSelectedAnimatedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)setDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}

@end
