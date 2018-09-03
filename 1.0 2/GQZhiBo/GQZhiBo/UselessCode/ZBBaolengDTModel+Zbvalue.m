#import "ZBBaolengDTModel+Zbvalue.h"
@implementation ZBBaolengDTModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}

@end
