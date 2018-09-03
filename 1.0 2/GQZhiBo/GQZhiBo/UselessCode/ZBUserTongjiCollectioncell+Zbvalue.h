#import <UIKit/UIKit.h>
#import "ZBUserTongjiModel.h"
#import "ZBSymbolsValueFormatter.h"
#import "ZBDateValueFormatter.h"
#import "ZBSetValueFormatter.h"
#import "ZBUserTuijianNumView.h"
#import "ZBRoundUserView.h"
#import "ZBUserTongjiCollectioncell.h"

@interface ZBUserTongjiCollectioncell (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue;
+ (BOOL)markYZbvalue:(NSInteger)ZBValue;
+ (BOOL)lineViewZbvalue:(NSInteger)ZBValue;
+ (BOOL)setDataZbvalue:(NSInteger)ZBValue;
+ (BOOL)chartValueSelectedEntryHighlightZbvalue:(NSInteger)ZBValue;
+ (BOOL)chartValueNothingSelectedZbvalue:(NSInteger)ZBValue;

@end
