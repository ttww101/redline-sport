#define  cellGuanzhuViewController @"cellGuanzhuViewController"
#import "ZBSaiTableViewCell.h"
#import "ZBLiveScoreModel.h"
#import "ZBGuanzhuViewController.h"
@interface ZBGuanzhuViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray *arrData;
@end
@implementation ZBGuanzhuViewController
- (id)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.tableView];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAttention];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar-14) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZBSaiTableViewCell class] forCellReuseIdentifier:cellGuanzhuViewController];
        [self setupHeaderView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [_tableView reloadData];
    }
    return _tableView;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes;
        if (self.arrData.count == 0) {
            attributes= @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        }else{
            attributes= @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        }
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"] ) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = [UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)setupHeaderView {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = font13;
    self.tableView.mj_header = header;
}
- (void)headerRefreshData
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellGuanzhuViewController];
    if (!cell) {
        cell = [[ZBSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellGuanzhuViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.arrData.count > 0) {
        cell.ScoreModel = [self.arrData objectAtIndex:indexPath.row];
        cell.contentView.backgroundColor = colorfbfafa;
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    UIView *marginView = [UIView new];
    marginView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:marginView];
    [marginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(cell.contentView);
        make.height.mas_equalTo(5);
    }];
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrData.count > 0) {
        ZBLiveScoreModel *model = [_arrData objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
        return 80;
    }
    return 0;
}
- (void)getAttention
{
    NSString *documentsPath = [ZBMethods getDocumentsPath];
    NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
    NSArray *arrAttentionMid = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath]];
    if (arrAttentionMid.count == 0) {
        _arrData = [NSMutableArray array];
        self.defaultFailure = default_noGame;
        [self.tableView reloadData];
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    NSString *ids = [arrAttentionMid componentsJoinedByString:@","];
    [parameter setObject:ids forKey:@"ids"];
    [[ZBDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_focus] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [[NSMutableArray alloc] initWithArray:[ZBLiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
            [self.tableView reloadData];
            NSMutableArray *arrMid = [NSMutableArray array];
            for (int i = 0; i<_arrData.count; i++) {
                ZBLiveScoreModel *liveM = [_arrData objectAtIndex:i];
                [arrMid addObject:[NSString stringWithFormat:@"%ld",liveM.mid]];
            }
            [NSKeyedArchiver archiveRootObject:arrMid toFile:arrayPath];
        }else{
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        if (self.defaultFailure.length == 0) {
            self.defaultFailure = @"";
        }
        
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
@end
