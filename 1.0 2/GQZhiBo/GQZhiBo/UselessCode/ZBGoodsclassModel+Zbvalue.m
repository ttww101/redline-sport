#import "ZBGoodsclassModel+Zbvalue.h"
@implementation ZBGoodsclassModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}

@end
