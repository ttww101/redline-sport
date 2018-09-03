#import "ZBUMStatisticsMgr.h"
@implementation ZBUMStatisticsMgr
IMPLEMENTATION_SINGLETON(ZBUMStatisticsMgr)
#pragma mark - ViewStatics -
- (void)viewStaticsBeginWithMarkStr:(NSString *)markStr {
    [MobClick beginLogPageView:markStr];
}
- (void)viewStaticsEndWithMarkStr:(NSString *)markStr {
    [MobClick endLogPageView:markStr];
}
#pragma mark - ClickEvent -
@end
