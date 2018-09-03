#import "ZBRemindModel+Zbvalue.h"
@implementation ZBRemindModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}

@end
