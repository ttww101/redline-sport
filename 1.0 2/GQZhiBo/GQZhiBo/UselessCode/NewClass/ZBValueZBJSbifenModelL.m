#import "ZBValueZBJSbifenModelL.h"
@implementation ZBValueZBJSbifenModelL
+ (BOOL)eJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)mdataJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}

@end
