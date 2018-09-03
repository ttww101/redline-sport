#import "ZBUserlistModel+Zbvalue.h"
@implementation ZBUserlistModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
