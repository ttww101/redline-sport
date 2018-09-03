#import "ZBJiaoYiModel+Zbvalue.h"
@implementation ZBJiaoYiModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}

@end
