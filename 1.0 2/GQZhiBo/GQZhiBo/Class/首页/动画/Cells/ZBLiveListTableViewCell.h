#import <UIKit/UIKit.h>
#import "ZBLiveListModel.h"
@interface ZBLiveListTableViewCell : UITableViewCell
+ (ZBLiveListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(ZBLiveListModel *)model;
@end
