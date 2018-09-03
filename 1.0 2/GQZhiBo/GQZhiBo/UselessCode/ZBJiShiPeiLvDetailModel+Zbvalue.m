#import "ZBJiShiPeiLvDetailModel+Zbvalue.h"
@implementation ZBJiShiPeiLvDetailModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}

@end
