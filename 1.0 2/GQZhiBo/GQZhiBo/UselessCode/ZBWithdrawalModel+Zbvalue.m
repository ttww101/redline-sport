#import "ZBWithdrawalModel+Zbvalue.h"
@implementation ZBWithdrawalModel (Zbvalue)
+ (BOOL)modelContainerPropertyGenericClassZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}

@end
