#import "ZBJSPLDownTwoModel+Zbvalue.h"
@implementation ZBJSPLDownTwoModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}

@end
