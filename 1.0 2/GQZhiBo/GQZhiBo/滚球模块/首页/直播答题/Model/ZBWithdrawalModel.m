#import "ZBWithdrawalModel.h"
@implementation ZBWithdrawalModel
@end
@implementation WithdrawaListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : NSClassFromString(@"ZBWithdrawalModel") };
}
@end
