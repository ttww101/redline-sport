#import "ZBPanwangCollectCell+Zbvalue.h"
@implementation ZBPanwangCollectCell (Zbvalue)
+ (BOOL)setTypeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)tableZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}

@end
