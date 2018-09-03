#import "ZBCommentsView+Zbvalue.h"
@implementation ZBCommentsView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)loadDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)configUIZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)replyActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)inputShareActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)inputCommentActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)replyBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)shareBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)commentBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)badgeNumberLabelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}

@end
