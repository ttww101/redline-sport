#import "ZBNewslistModel+Zbvalue.h"
@implementation ZBNewslistModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}

@end
