#import <Foundation/Foundation.h>
@interface ZBAppConfig : NSObject
+ (instancetype)shareInstance;
- (void)initialize;
@end
