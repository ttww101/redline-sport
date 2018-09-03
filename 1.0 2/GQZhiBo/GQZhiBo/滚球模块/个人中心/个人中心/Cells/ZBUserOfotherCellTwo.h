#import <UIKit/UIKit.h>
@protocol UserOfotherCellTwoDelegate<NSObject>
@optional
- (void)attentionBtnClick:(UIButton *)btn;
- (void)upDownBtnClick:(BOOL)selected;
@end
@interface ZBUserOfotherCellTwo : UITableViewCell
@property (nonatomic, strong) ZBUserModel *model;
@property (nonatomic, assign) BOOL showMoreUserInfo;
@property (nonatomic, weak) id<UserOfotherCellTwoDelegate> delegate;
@end
