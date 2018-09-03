#import "ZBBasicTableView.h"
#import "ZBTuijianDatingCell.h"
#import "ZBLiveScoreModel.h"
@protocol TuijianDatingTableViewDelegate <NSObject>
@optional
@end
@interface ZBTuijianDatingTableView : ZBBasicTableView
@property (nonatomic, assign) typeTuijianCell type;
@property (nonatomic, weak) id <TuijianDatingTableViewDelegate> delegateTuijianDatingTableView;
@property (nonatomic, strong) ZBLiveScoreModel *model;
@property (nonatomic, assign) BOOL hideFooter;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
