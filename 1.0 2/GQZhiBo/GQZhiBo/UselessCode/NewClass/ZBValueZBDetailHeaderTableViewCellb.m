#import "ZBValueZBDetailHeaderTableViewCellb.h"
@implementation ZBValueZBDetailHeaderTableViewCellb
+ (BOOL)EawakeFromNib:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)OSetselectedkAnimated:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}

@end
