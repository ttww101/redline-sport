#import "ZBRonyunDataSource+Zbvalue.h"
@implementation ZBRonyunDataSource (Zbvalue)
+ (BOOL)shareInstanceZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}

@end
