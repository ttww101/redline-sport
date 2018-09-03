#import "ZBBasicModel.h"
#import "ZBInfoListModel.h"
#import "ZBMedalsModel.h"

@interface ZBInfoListModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)GuestScoreJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)HomeScoreJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)multipleJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)recommend_countJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)info_countJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)fansJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)win_rateJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)profit_rateJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)create_timeJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)MatchTimeJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
