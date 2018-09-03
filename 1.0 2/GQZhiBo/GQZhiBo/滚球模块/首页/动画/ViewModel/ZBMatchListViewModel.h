#import <Foundation/Foundation.h>
#import "ZBLiveListModel.h"
typedef void (^requestCallBack)(BOOL isSuccess, id response);
@interface ZBMatchListViewModel : NSObject
- (void)fetchMatchDateInterfaceWithParameter:(id)parameter  callBack:(requestCallBack)response;
@end
