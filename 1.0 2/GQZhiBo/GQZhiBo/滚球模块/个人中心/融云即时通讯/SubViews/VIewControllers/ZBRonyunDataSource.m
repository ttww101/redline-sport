#import "ZBRonyunDataSource.h"
@implementation ZBRonyunDataSource
+ (ZBRonyunDataSource *)shareInstance {
    static ZBRonyunDataSource *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
@end
