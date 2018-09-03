#import <UIKit/UIKit.h>
#import "ZBRecommandListModel.h"
@interface ZBBangDanListCell : UITableViewCell
@property (nonatomic, assign)NSInteger cellNum;
@property (nonatomic, strong)ZBRecommandListModel  *model;
@property (nonatomic, assign)NSInteger type;
@end
