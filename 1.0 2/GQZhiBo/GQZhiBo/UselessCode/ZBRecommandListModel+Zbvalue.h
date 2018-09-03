#import "ZBBasicModel.h"
#import "ZBRecommandListModel.h"
#import "ZBMedalsModel.h"

@interface ZBRecommandListModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)rankJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)realnumsJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
