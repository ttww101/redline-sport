#import "ZBValueZBTongpeiDetailModelM.h"
@implementation ZBValueZBTongpeiDetailModelM
+ (BOOL)iJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)rmatchsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}

@end
