#import <Foundation/Foundation.h>
@interface ZBUMStatisticsMgr : NSObject
INTERFACE_SINGLETON(ZBUMStatisticsMgr)
- (void)viewStaticsBeginWithMarkStr:(NSString *)markStr;
- (void)viewStaticsEndWithMarkStr:(NSString *)markStr;
@end
