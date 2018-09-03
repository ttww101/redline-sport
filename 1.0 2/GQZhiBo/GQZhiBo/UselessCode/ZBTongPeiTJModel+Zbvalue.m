#import "ZBTongPeiTJModel+Zbvalue.h"
@implementation ZBTongPeiTJModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}

@end
