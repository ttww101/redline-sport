#import <UIKit/UIKit.h>
#import "ZBLiveEventMedel.h"
@interface ZBBisaiTongjiCell : UITableViewCell
@property (nonatomic, strong) ZBLiveEventMedel *model;
-(void)tongjimmodel:(ZBLiveEventMedel*)model;
@end
