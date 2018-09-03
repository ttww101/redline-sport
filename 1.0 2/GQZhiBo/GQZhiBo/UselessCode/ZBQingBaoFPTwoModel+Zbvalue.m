#import "ZBQingBaoFPTwoModel+Zbvalue.h"
@implementation ZBQingBaoFPTwoModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}

@end
