#import "LiveListArrayModel+Zbvalue.h"
@implementation LiveListArrayModel (Zbvalue)
+ (BOOL)modelContainerPropertyGenericClassZbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}

@end
