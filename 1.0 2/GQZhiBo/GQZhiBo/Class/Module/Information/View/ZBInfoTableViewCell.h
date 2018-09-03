#import <UIKit/UIKit.h>
#import "ZBInfoModel.h"
@class ZBInfoTableViewCell;
@protocol InfoTableViewCellDelegate <NSObject>
- (void)tableViewCell:(ZBInfoTableViewCell *)cell likeComment:(UIButton *)comment;
- (void)tableViewCell:(ZBInfoTableViewCell *)cell moreComments:(id)moreComments;
@end
@interface ZBInfoTableViewCell : UITableViewCell
@property (nonatomic, weak) id <InfoTableViewCellDelegate> delegate;
@property (nonatomic , strong) InfoGroupModel *model;
+ (ZBInfoTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)hideMoreReply;
@end
