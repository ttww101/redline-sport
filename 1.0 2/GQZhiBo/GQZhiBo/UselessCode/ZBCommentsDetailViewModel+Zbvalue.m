#import "ZBCommentsDetailViewModel+Zbvalue.h"
@implementation ZBCommentsDetailViewModel (Zbvalue)
+ (BOOL)fetchCommentsListWithParamsCallbackZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}

@end
