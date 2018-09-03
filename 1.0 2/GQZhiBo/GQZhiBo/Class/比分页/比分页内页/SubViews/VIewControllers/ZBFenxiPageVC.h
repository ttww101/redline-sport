#import "ZBBasicViewController.h"
#import "ZBViewPagerController.h"
#import "ZBLiveScoreModel.h"
@interface ZBFenxiPageVC : ZBBasicViewController
@property (nonatomic, strong) ZBLiveScoreModel *model;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger segIndex;
@end
