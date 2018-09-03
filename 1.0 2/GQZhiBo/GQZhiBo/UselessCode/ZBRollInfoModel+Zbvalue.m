#import "ZBRollInfoModel+Zbvalue.h"
@implementation ZBRollInfoModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}

@end
