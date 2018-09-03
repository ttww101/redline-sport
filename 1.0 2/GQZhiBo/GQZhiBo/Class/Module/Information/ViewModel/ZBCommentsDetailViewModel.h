#import <Foundation/Foundation.h>
typedef void(^requestCallBack)(BOOL isSucess, id response);
@interface ZBCommentsDetailViewModel : NSObject
- (void)fetchCommentsListWithParams:(NSDictionary *)params callBack:(requestCallBack)response;
@end
