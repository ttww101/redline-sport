#define  cellSaichengViewController @"cellSaichengViewController"
#import "ZBSaiTableViewCell.h"
#import "ZBLiveScoreModel.h"
#import "ZBQiciModel.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBJSbifenModel.h"
#import "ZBSaichengViewController.h"
#import "ZBSelectedDataView.h"
#import "ZBSelectedDateTitleView.h"
#import "ZBDCindexBtn.h"
#import "ZBHSInfiniteScrollView.h"
#define NUMBER_OF_VISIBLE_VIEWS 5
@interface ZBSaichengViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,SelecterDateViewDelegate,SelectedDateTitleViewDelegate,DCindexBtnDelegate,HSInfiniteScrollViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrDataQici;
@property (nonatomic, assign) NSInteger currentFlag;
@property (nonatomic, assign) NSInteger currentdate;
@property (nonatomic, assign) NSInteger currentSeleData;
@property (nonatomic, assign) NSInteger titleViewFlag;
@property (nonatomic, strong) ZBSelectedDataView *dataView;
@property (nonatomic, assign) CGFloat       seletedHeight;
@property (nonatomic, strong) NSMutableArray        *timeArr;
@property (nonatomic, strong) UIButton *selectedHeaderBtn;
@property (nonatomic, strong) ZBSelectedDateTitleView *dataTitleView;
@property (nonatomic, strong) ZBHSInfiniteScrollView            *titleScrollView;
@property (nonatomic, assign) CGFloat                         viewSize;
@property (nonatomic, strong) ZBDCindexBtn *indexBtn;
@property (nonatomic, strong) UITableViewCell *seleCell;
@property (nonatomic, strong) UIView        *dataLineView;
@end
@implementation ZBSaichengViewController
- (id)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.dataTitleView];
        [self.dataTitleView addSubview:self.dataLineView];
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.indexBtn];
        self.view.backgroundColor = [UIColor whiteColor];
        [[ZBMethods getMainWindow] addSubview:self.dataView];
        [self loadDataQiciJishiViewController];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShowType) name:@"NSNotificationchangeShowType" object:nil];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(biFenChange:) name:biFenTitleChange object:nil];
    self.viewSize = CGRectGetWidth(self.view.bounds) / NUMBER_OF_VISIBLE_VIEWS;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        _dataView.alpha = 0;
    }completion:^(BOOL finished) {
        _dataView.hidden = YES;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    self.seletedHeight = 60;
    [self buildElements];
}
- (void)biFenChange:(NSNotification *)dict {
    _titleViewFlag = (NSInteger)dict.userInfo[@"bifenTitleFlag"];
}
- (void)changeShowType
{
    if (_currentFlag == 0) {
        [self headerRefreshData];
    }
}
- (NSMutableArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [NSMutableArray array];
    }
    return _timeArr;
}
- (void)buildElements {
        [self.view addSubview:self.dataTitleView];
}
# pragma mark - ZBHSInfiniteScrollView dataSource
- (NSInteger)numberOfViews {
    return _arrDataQici.count;
}
- (NSInteger)numberOfVisibleViews {
    return NUMBER_OF_VISIBLE_VIEWS;
}
# pragma mark - ZBHSInfiniteScrollView delegate -
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIView *baseView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewSize, self.seletedHeight)];
    UILabel *labWeek = [[UILabel alloc] init];
    UILabel *labTime = [UILabel new];
    baseView.userInteractionEnabled = YES;
    ZBQiciModel *model = [_arrDataQici objectAtIndex:index];
    labWeek.text = [NSString stringWithFormat:@"%@",model.week];
    labWeek.textColor = colorf66666;
    labWeek.font = font14;
    labWeek.textAlignment = NSTextAlignmentCenter;
    labTime.text = [NSString stringWithFormat:@"%@",model.time];
    labTime.textColor = colorf66666;
    labTime.font = font14;
    labTime.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *viewGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    viewGes.numberOfTapsRequired = 1;
    baseView.tag = index;
    [baseView addGestureRecognizer:viewGes];
    [baseView addSubview:labWeek];
    [baseView addSubview:labTime];
    [labWeek mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(baseView);
        make.top.equalTo(baseView).offset(5);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labWeek.mas_bottom).offset(1);
        make.centerX.equalTo(labWeek);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [labWeek addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(baseView);
        make.width.mas_equalTo(0.5);
    }];
    return baseView;
}
- (void)scrollView:(ZBHSInfiniteScrollView *)scrollView didScrollToIndex:(NSInteger)index {
    NSLog(@"scroll to: %ld", index);
}
- (void)viewTap: (UIGestureRecognizer *)ges {
    [self ZBSelecterMatchView:nil selectedAtIndex:ges.view.tag WithSelectedName:nil];
}
- (ZBHSInfiniteScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[ZBHSInfiniteScrollView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, self.seletedHeight)];
    }
    return _titleScrollView;
}
- (UIView *)dataLineView {
    if (!_dataLineView) {
        _dataLineView = [[UIView alloc] initWithFrame:CGRectMake(0,0, Width, 1)];
        _dataLineView.backgroundColor = colorEEEEEE;
    }
    return _dataLineView;
}
- (ZBSelectedDateTitleView *)dataTitleView
{
    if (!_dataTitleView) {
        _dataTitleView = [[ZBSelectedDateTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, 60 / 2 + 9)];
        _dataTitleView.delegate = self;
    }
    return _dataTitleView;
}
- (void)selectedDateViewIndex:(NSInteger)index
{
    switch (index) {
        case 1:
        {
            [self showOrhideDateView];
        }
            break;
        case 2:
        {
            _currentdate--;
            if (_arrDataQici.count > 0) {
                ZBQiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
                [self loadDataJishiViewControllerWithQici:model];
                [self clearSelectedSaved];
                [_dataView updateSelectedIndex:_currentdate];
            }
        }
            break;
        case 3:
        {
            _currentdate++;
            if (_arrDataQici.count > 0) {
                ZBQiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
                [self loadDataJishiViewControllerWithQici:model];
                [self clearSelectedSaved];
                [_dataView updateSelectedIndex:_currentdate];
            }
        }
            break;
        default:
            break;
    }
}
- (ZBSelectedDataView *)dataView
{
    if (!_dataView) {
        _dataView = [[ZBSelectedDataView alloc] initWithFrame:CGRectMake(0, 0, Width, Height )];
        _dataView.alpha = 0;
        _dataView.hidden = YES;
        _dataView.delegate = self;
    }
    return _dataView;
}
- (void)ZBSelecterMatchView:(ZBSelectedDataView *)matchView selectedAtIndex:(NSInteger)index WithSelectedName:(NSString *)name
{
        [self showOrhideDateView];
    _currentdate = index;
    ZBQiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
    [self loadDataJishiViewControllerWithQici:model];
    [self clearSelectedSaved];
    [_dataTitleView setDateIndex:_currentdate];
}
- (void)touchTapView
{
    [self showOrhideDateView];
}
- (void)showOrhideDateView
{
    if (_dataView.hidden) {
        _dataView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _dataView.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _dataView.alpha = 0;
        }completion:^(BOOL finished) {
            _dataView.hidden = YES;
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)refreshDataByChangeFlag:(NSInteger)flag
{
    _currentFlag = flag;
    [self loadDataQiciJishiViewController];
    [self clearSelectedSaved];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 39+ 14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar - 39- 14) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZBSaiTableViewCell class] forCellReuseIdentifier:cellSaichengViewController];
        [self setupHeaderView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
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
            self.defaultFailure = default_noMatch;
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
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    if (self.arrData.count == 0 ) {
        return [UIImage imageNamed:@"d1"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (ZBDCindexBtn *)indexBtn
{
    if (!_indexBtn) {
    }
    return _indexBtn;
}
- (void)scrollToScale:(CGFloat)scaleY
{
    [self.tableView setContentOffset:CGPointMake(0, (self.tableView.contentSize.height - self.tableView.height)*scaleY) animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_arrData.count>0) {
        _indexBtn.hidden = NO;
    }
    CGFloat scaleY = scrollView.contentOffset.y/(scrollView.contentSize.height - self.tableView.height);
    [_indexBtn updateScrollFrame:scaleY];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; 
{
}
- (void)hideIndexBtn
{
    _indexBtn.hidden = YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    _seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
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
    if (_arrDataQici.count>0) {
        ZBQiciModel *qici = [_arrDataQici objectAtIndex:_currentdate];
        [self loadDataJishiViewControllerWithQici:qici];
    }else{
        [self loadDataQiciJishiViewController];
    }
    [self clearSelectedSaved];
    [self.tableView.mj_header endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_arrData) { 
        return _arrData.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrData.count > 0 ) {
        ZBJSbifenModel *model = [_arrData objectAtIndex:section];
        return model.data.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSaichengViewController];
    if (!cell) {
        cell = [[ZBSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSaichengViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = colorfbfafa;
    ZBJSbifenModel *model;
    if (_arrData.count > 0) {
         model = [_arrData objectAtIndex:indexPath.section];
        cell.ScoreModel = [model.data objectAtIndex:indexPath.row];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row < model.data.count) {
        UIView *marginView = [UIView new];
        marginView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:marginView];
        [marginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(cell.contentView);
            make.height.mas_equalTo(5);
        }];
    }else{
        return nil;
    }
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBLiveScoreModel *model;
    if (_arrData.count > 0) {
        ZBJSbifenModel *jsmodel = [_arrData objectAtIndex:indexPath.section];
        model = [jsmodel.data objectAtIndex:indexPath.row];
    }
    if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
        return 108;
    }
    return 80;
}
- (void)loadDataQiciJishiViewController
{
    if (_currentFlag == 0 || _currentFlag == 1) {
        _dataTitleView.isBeforeTwo = YES;
    }else{
        _dataTitleView.isBeforeTwo = NO;
    }
    NSString *urlStage = @"";
    switch (_currentFlag) {
        case 0:
        {
            urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageAll];
        }
            break;
        case 1:
        {
            urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageJC];
        }
            break;
        case 2:
        {
            urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageBD];
        }
            break;
        case 3:
        {
            urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageZC];
        }
            break;
        default:
            break;
    }
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:urlStage Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        _arrDataQici = [[NSMutableArray alloc] initWithArray:[ZBQiciModel arrayOfEntitiesFromArray:responseOrignal]];
        if (_arrDataQici.count == 0) {
            [_arrData removeAllObjects];
            [self.tableView reloadData];
            return ;
        }
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<_arrDataQici.count; i++) {
            ZBQiciModel *model = [_arrDataQici objectAtIndex:i];
            if (model.iscurrent == 1) {
                 break;
            }
            [arr addObject:model];
        }
        if (arr.count == _arrDataQici.count) {
            _arrDataQici = [NSMutableArray arrayWithObject:[arr lastObject]];
        }else{
            [_arrDataQici removeObjectsInArray:arr];
        }
        _dataView.arrData = _arrDataQici;
        _dataTitleView.arrData = _arrDataQici;
        ZBQiciModel *model = [_arrDataQici objectAtIndex:0];
        _currentdate = 0;
        [self loadDataJishiViewControllerWithQici:model];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [_arrData removeAllObjects];
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)loadDataJishiViewControllerWithQici:(ZBQiciModel *)model
{
    NSString *urlJsbf;
    switch (_currentFlag) {
        case 0:
        {
            NSString *urlLeague = @"";
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
                urlLeague = @"league/";
            }
            urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_all_future,urlLeague,model.name,url_jsbf_json];
            NSLog(@"%@",urlJsbf);
        }
            break;
        case 1:
        {
            urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_jc_future,model.name,url_jsbf_json];
        }
            break;
        case 2:
        {
            urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_bd,model.name,url_jsbf_json];
        }
            break;
        case 3:
        {
            urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_zc,model.name,url_jsbf_json];
        }
            break;
        default:
            break;
    }
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:urlJsbf Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSMutableArray *arrLoad =[[NSMutableArray alloc] initWithArray:[ZBJSbifenModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"matchs"]]];
                _arrSelectedSaishi = [[NSArray alloc] initWithArray:[ZBBIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"allindex"]]];
                _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[ZBBIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"jcindex"]]];
                _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[ZBBIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"oddsindex"]]];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i<arrLoad.count; i++) {
            ZBJSbifenModel *jsmodel = [arrLoad objectAtIndex:i];
            ZBJSbifenModel *sendJs = [[ZBJSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arr addObject:sendJs];
            for (int m = 0; m<jsmodel.data.count; m++) {
                ZBLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                if (model.matchstate == 0)
                {
                    [sendJs.data addObject:model];
                }
            }
        }
        _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arr];
        _arrData = [[NSMutableArray alloc] initWithArray:arr];
        [self.tableView reloadData];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [_arrData removeAllObjects];
        self.defaultFailure = default_noMatch;
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)clearSelectedSaved
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    NSString *documentPath = [ZBMethods getDocumentsPath];
    NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
    NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
    NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
