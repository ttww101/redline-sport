#import "ZBBasicViewController.h"
@interface ZBJishiViewController : ZBBasicViewController
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong)NSMutableArray *memeryArrAllPart;
@property (nonatomic, strong) UITableView *tableView;




@property (nonatomic, strong) NSArray *arrSelectedSaishi;
@property (nonatomic, strong) NSArray *arrSelectedSaishiJingcai;
@property (nonatomic, strong) NSArray *arrSelectedSaishiChupan;



- (void)refreshDataByChangeFlag:(NSInteger)flag;


@property (nonatomic , copy) NSString *filterParameters;


@end
