#import <UIKit/UIKit.h>
@interface ZBUserTuijianTable : ZBBasicTableView
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger oddtype;
- (void)loadNewData;
@end
