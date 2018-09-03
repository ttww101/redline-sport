#import "ZBPanWangModel+Zbvalue.h"
@implementation ZBPanWangModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
