#import "ZBBasicModel.h"
#import "ZBBaolengDTModel.h"
#import "ZBBaolengMatchModel.h"
#import "ZBBaolengDetailModel.h"

@interface ZBBaolengDetailModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)bodyJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)listJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
