#import "ZBBasicTableView.h"
#import "ZBLiveScoreModel.h"
#import "SRWebSocket.h"
@interface ZBZhiboTableView : UITableView
@property (nonatomic, strong) ZBLiveScoreModel *model;
@property (nonatomic,strong) SRWebSocket*webSocket;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)addSegMent;
@end
