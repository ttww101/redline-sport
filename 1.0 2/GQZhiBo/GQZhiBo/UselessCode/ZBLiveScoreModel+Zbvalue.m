#import "ZBLiveScoreModel+Zbvalue.h"
@implementation ZBLiveScoreModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}

@end
