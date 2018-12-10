#define  cellGuanzhuViewController @"cellGuanzhuViewController"
#import "ZBSaiTableViewCell.h"
#import "ZBLiveScoreModel.h"
#import "ZBGuanzhuViewController.h"
#import "ZBSelectedDateTitleView.h"
#import "DatePickerView.h"


@interface ZBGuanzhuViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate, SelectedDateTitleViewDelegate, DatePickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) ZBSelectedDateTitleView *dataTitleView;
@property (nonatomic, strong) NSMutableArray *arrDataQici;



@end

@implementation ZBGuanzhuViewController

#pragma mark - DatePickerViewDelegate

- (void)didSelectedDate:(NSString *)selectDate {
    _date = [selectDate copy];
    [self getAttention];
    
}

#pragma mark SelectedDateTitleViewDelegate

- (void)ZBSelectedDateTitleViewDidAction:(NSArray *)array {
    DatePickerView *picker =  [DatePickerView showDatePicker:array];
    picker.delegate = self;
}


#pragma mark - Lazy Load

- (ZBSelectedDateTitleView *)dataTitleView
{
    if (!_dataTitleView) {
        _dataTitleView = [[ZBSelectedDateTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, 60 / 2 + 9)];
        _dataTitleView.delegate = self;
    }
    return _dataTitleView;
}

#pragma mark - ************  以下高人所写  ************


- (id)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.dataTitleView];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 39+ 14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar - 39- 14) style:UITableViewStylePlain];
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

- (void)headerRefreshData{
    [self getAttention];
    [self.tableView.mj_header endRefreshing];
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
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(_date) forKey:@"day"];
    [[ZBDCHttpRequest shareInstance] sendRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_focusd_matches] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [[NSMutableArray alloc] initWithArray:[ZBLiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matches"]]];
             _arrDataQici = [[NSMutableArray alloc] initWithArray:[ZBQiciModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"dates"]]];
            if (_arrDataQici.count == 0) {
                [_arrData removeAllObjects];
                [self.tableView reloadData];
                return ;
            }
            NSString *nums = [[[responseOrignal objectForKey:@"date"] objectForKey:@"focusNum"] stringValue];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"attentionNum" object:nil userInfo:@{@"num":PARAM_IS_NIL_ERROR(nums)}];
            _dataTitleView.arrData = _arrDataQici;
            [self.tableView reloadData];
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *documentsPath = [ZBMethods getDocumentsPath];
                NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
                NSMutableArray *attentionArray = [NSMutableArray array];
                for (NSInteger i = 0; i < _arrData.count; i ++) {
                    ZBLiveScoreModel *model = _arrData[i];
                    [attentionArray addObject:[NSString stringWithFormat:@"%ld",model.mid]];
                }
                 [NSKeyedArchiver archiveRootObject:attentionArray toFile:arrayPath];
            });
            
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
