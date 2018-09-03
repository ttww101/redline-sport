#import <UIKit/UIKit.h>
#import "ZBTuijiandatingModel.h"
typedef NS_ENUM(NSInteger,TuijianDetailHeaderViewtype)
{
    TuijianDetailHeaderViewShowContent = 1,
    TuijianDetailHeaderViewHideContent = 0,
};
@interface ZBTuijianDetailHeaderView : UITableViewCell
@property (nonatomic, assign) CGFloat webViewHight;
@property (nonatomic) TuijianDetailHeaderViewtype type;
@property (nonatomic, strong) ZBTuijiandatingModel *model;
@end
