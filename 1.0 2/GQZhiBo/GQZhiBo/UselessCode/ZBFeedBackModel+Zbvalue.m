#import "ZBFeedBackModel+Zbvalue.h"
@implementation ZBFeedBackModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}

@end
