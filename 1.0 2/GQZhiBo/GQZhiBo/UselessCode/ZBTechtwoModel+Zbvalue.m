#import "ZBTechtwoModel+Zbvalue.h"
@implementation ZBTechtwoModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}

@end
