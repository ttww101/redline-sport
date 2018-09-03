#import "ZBValueZBQiciModelt.h"
@implementation ZBValueZBQiciModelt
+ (BOOL)cJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}
+ (BOOL)BcreateTimeJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)cupdateTimeJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}

@end
