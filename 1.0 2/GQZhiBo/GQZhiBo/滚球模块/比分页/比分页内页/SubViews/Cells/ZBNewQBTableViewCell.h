#import <UIKit/UIKit.h>
#import "ZBInfoListModel.h"
@interface ZBNewQBTableViewCell : UITableViewCell
@property (nonatomic, strong) ZBInfoListModel *model;
@property (nonatomic, assign) BOOL hideBottomView;
@end
