#import "ZBToolKitViewModel+Zbvalue.h"
@implementation ZBToolKitViewModel (Zbvalue)
+ (BOOL)createModelListArrayZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}

@end
