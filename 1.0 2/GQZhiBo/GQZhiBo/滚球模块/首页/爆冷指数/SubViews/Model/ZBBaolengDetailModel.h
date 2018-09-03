#import "ZBBasicModel.h"
#import "ZBBaolengDTModel.h"
#import "ZBBaolengMatchModel.h"
@interface ZBBaolengDetailModel : ZBBasicModel
@property (nonatomic, strong) ZBBaolengDTModel *body;
@property (nonatomic, strong) NSArray *list;
@end
