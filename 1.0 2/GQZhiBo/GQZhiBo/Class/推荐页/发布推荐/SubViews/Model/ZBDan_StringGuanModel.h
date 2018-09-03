#import "ZBBasicModel.h"
#import "ZBDan_StringMatchsModel.h"
@interface ZBDan_StringGuanModel : ZBBasicModel
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, retain)NSString *index;
@property (nonatomic, retain)NSMutableArray *matchs;
@end
