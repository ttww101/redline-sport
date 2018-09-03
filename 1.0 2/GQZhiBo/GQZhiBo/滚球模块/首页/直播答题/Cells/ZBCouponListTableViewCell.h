#import <UIKit/UIKit.h>
#import "ZBCouponModel.h"
@interface ZBCouponListTableViewCell : UITableViewCell
+ (ZBCouponListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(id)model;
@end
