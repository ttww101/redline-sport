#import <Foundation/Foundation.h>
#import "ZBUserModel.h"
typedef void(^requestStart)(id requestOrignal);
typedef void (^UserInfo)(ZBUserModel* user);
@interface ZBUniversalNetwork : NSObject
+ (void)getUserModelWithUserId:(NSInteger)Idid WithUserModel:(UserInfo)user;
+ (void)getUserWithUserId:(NSInteger)Idid WithUserModel:(void(^)(ZBUserModel* useInfo))user;
@end
