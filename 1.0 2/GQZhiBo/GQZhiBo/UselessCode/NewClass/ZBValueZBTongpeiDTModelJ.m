#import "ZBValueZBTongpeiDTModelJ.h"
@implementation ZBValueZBTongpeiDTModelJ
+ (BOOL)rJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)XsameJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)ZallJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}

@end
