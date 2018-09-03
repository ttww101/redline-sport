#import "ZBPeiLvDetailModel+Zbvalue.h"
@implementation ZBPeiLvDetailModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
