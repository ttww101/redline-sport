#import "ZBJSPLDownMode+Zbvalue.h"
@implementation ZBJSPLDownMode (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}

@end
