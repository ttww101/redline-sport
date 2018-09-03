#import <UIKit/UIKit.h>
@interface ZBHeaderTableViewCell : UITableViewCell
@property (nonatomic , copy) NSString *title;
+ (ZBHeaderTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
@end
