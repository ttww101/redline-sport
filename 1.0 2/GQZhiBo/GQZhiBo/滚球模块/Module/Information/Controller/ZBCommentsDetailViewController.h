#import "ZBBasicViewController.h"
#import "ZBInfoModel.h"
@interface ZBCommentsDetailViewController : ZBBasicViewController
@property (nonatomic , strong) InfoGroupModel *dataModel;
@property (nonatomic , strong) NSString *ID;
@property (nonatomic , copy) NSString *commentsID;
@property (nonatomic , strong) NSString *module;
@end
