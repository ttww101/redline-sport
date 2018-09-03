#import <UIKit/UIKit.h>
#import "ZBCommentModel.h"
#import "ZBCommentChildModel.h"
typedef NS_ENUM(NSInteger,typeCommentCell)
{
    typeCommentCellTuijian = 0,
    typeCommentCellZixun = 1,
};
@protocol TuijianDetailCommentCellDelegate<NSObject>
@optional
- (void)didShowMoreBtn;
- (void)touchBasicViewToHideHudViewWithIdid:(NSInteger)Idid;
@end
@interface ZBTuijianDetailCommentCell : UITableViewCell
@property (nonatomic, strong) ZBCommentModel *model;
@property (nonatomic, weak) id<TuijianDetailCommentCellDelegate> delegate;
@property (nonatomic) typeCommentCell type;
- (void)hideHudView;
@end
