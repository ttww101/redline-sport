#import "ZBValueZBBaolengDetailModelh.h"
@implementation ZBValueZBBaolengDetailModelh
+ (BOOL)gJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)WbodyJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)flistJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}

@end
