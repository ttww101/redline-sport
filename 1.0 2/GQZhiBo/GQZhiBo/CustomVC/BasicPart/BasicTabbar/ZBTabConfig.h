#import <Foundation/Foundation.h>
#import "ZBDCTabBarController.h"
@interface ZBTabConfig : NSObject
@property (nonatomic, readonly, strong) ZBDCTabBarController *tabBarController;
@property (nonatomic, copy) NSString *currentPage;
@end
