#import "ZBCommentChildModel+Zbvalue.h"
@implementation ZBCommentChildModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}

@end
