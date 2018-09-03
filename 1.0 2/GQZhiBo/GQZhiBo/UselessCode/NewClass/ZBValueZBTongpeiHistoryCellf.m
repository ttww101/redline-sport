#import "ZBValueZBTongpeiHistoryCellf.h"
@implementation ZBValueZBTongpeiHistoryCellf
+ (BOOL)xawakeFromNib:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)PSetselectedLAnimated:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}
+ (BOOL)SSetdata:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}

@end
