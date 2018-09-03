#import <Foundation/Foundation.h>
#import "ZBDCTabBarController.h"
@interface ZBTbableConfig : NSObject
@property (nonatomic, readonly, strong) ZBDCTabBarController *tableBarController;
@property (nonatomic, copy) NSString *currentPage;
@end
