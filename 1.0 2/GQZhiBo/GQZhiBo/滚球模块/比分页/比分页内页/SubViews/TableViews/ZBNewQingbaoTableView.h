#import <UIKit/UIKit.h>
@protocol NewQingbaoTableViewDelegate <NSObject>
- (void)headerRefreshNewQB;
@end
@interface ZBNewQingbaoTableView : ZBBasicTableView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrhomeInfo;
@property (nonatomic, strong) NSArray *arrawayInfo;
@property (nonatomic, strong) NSArray *arrneutralInfo;
@property (nonatomic, strong) NSMutableArray *jiDianArr;
@property (nonatomic, weak) id<NewQingbaoTableViewDelegate>delegateNewQB;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
