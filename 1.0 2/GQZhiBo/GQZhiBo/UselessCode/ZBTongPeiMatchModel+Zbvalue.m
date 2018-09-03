#import "ZBTongPeiMatchModel+Zbvalue.h"
@implementation ZBTongPeiMatchModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}

@end
