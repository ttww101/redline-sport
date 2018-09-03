#import "ZBBasicModel.h"
#import "ZBUserTongjiModel.h"
@interface ZBUserTongjiAllModel : ZBBasicModel
@property (nonatomic, strong) ZBUserTongjiModel *month;
@property (nonatomic, strong) ZBUserTongjiModel *all;
@property (nonatomic, strong) ZBUserTongjiModel *week;
@property (nonatomic, strong) NSArray *recent;
@end
