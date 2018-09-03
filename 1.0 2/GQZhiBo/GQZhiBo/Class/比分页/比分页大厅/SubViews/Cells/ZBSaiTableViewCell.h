#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"
#import "ZBLivingModel.h"
@interface ZBSaiTableViewCell : UITableViewCell
@property (nonatomic, strong) ZBLiveScoreModel *ScoreModel;
@property (nonatomic, assign) int peilvIndex;
@property (nonatomic, assign) int SaishiType;
@end
