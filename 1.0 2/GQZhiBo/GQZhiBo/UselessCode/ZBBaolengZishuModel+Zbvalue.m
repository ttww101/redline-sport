#import "ZBBaolengZishuModel+Zbvalue.h"
@implementation ZBBaolengZishuModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
