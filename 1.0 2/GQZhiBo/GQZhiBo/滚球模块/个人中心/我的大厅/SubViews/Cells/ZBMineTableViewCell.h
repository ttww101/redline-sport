#import <UIKit/UIKit.h>
#import "ZBMineModel.h"
@interface ZBMineTableViewCell : UITableViewCell
+ (ZBMineTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(ZBMineModel *)model;
@end
