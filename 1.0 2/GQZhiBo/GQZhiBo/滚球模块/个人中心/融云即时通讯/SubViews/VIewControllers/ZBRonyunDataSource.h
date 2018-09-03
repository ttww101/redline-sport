#import <Foundation/Foundation.h>
#define RongyunDataSource [ZBRonyunDataSource shareInstance]
@interface ZBRonyunDataSource : NSObject
+ (ZBRonyunDataSource *)shareInstance;
@end
