#import "ZBValueZBPanwangCollectCellO.h"
@implementation ZBValueZBPanwangCollectCellO
+ (BOOL)tSettype:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)utable:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
