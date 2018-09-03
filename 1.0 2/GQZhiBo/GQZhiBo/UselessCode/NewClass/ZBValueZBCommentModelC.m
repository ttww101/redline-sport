#import "ZBValueZBCommentModelC.h"
@implementation ZBValueZBCommentModelC
+ (BOOL)QJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)ochildJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}

@end
