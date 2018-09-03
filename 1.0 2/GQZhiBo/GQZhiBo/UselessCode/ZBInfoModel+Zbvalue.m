#import "ZBInfoModel+Zbvalue.h"
@implementation ZBInfoModel (Zbvalue)
+ (BOOL)modelContainerPropertyGenericClassZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}

@end
