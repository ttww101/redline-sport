#import "ZBTokenModel+Zbvalue.h"
@implementation ZBTokenModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}

@end
