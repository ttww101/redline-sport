#import "ZBBasicModel.h"
@interface ZBNoticeModel : ZBBasicModel
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) BOOL iread;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@end
