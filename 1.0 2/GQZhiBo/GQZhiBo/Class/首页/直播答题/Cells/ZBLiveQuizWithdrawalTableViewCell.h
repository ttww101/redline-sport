#import <UIKit/UIKit.h>
#import "ZBWithdrawalModel.h"
@interface ZBLiveQuizWithdrawalTableViewCell : UITableViewCell
+ (ZBLiveQuizWithdrawalTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(id)model;
@end
