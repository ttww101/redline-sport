#import "ZBQiciModel+Zbvalue.h"
@implementation ZBQiciModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)createTimeJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)updateTimeJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}

@end
