#import "ZBBasicModel.h"
#import "ZBCommentModel.h"
#import "ZBCommentChildModel.h"

@interface ZBCommentModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)childJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
