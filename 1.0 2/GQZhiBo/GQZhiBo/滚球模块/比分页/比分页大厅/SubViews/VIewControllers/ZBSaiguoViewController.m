//
//  ZBSaiguoViewController.m
//  GQapp
//
//  Created by WQ on 2016/12/21.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#define  cellSaiguoViewController @"cellSaiguoViewController"
#import "ZBSaiTableViewCell.h"
#import "ZBLiveScoreModel.h"
#import "ZBQiciModel.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBJSbifenModel.h"
#import "ZBSaiguoViewController.h"
#import "ZBSelectedDataView.h"
#import "ZBSelectedDateTitleView.h"
#import "ZBSelectedSaiGuoTitleView.h"
#import "ZBDCindexBtn.h"
#import "ZBSelectedDTitleView.h"
#import "ZBHSInfiniteScrollView.h"
#import "ZBHSDashLineView.h"
#define COLOR [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]
#define NUMBER_OF_VISIBLE_VIEWS 5

@interface ZBSaiguoViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,SelecterDateViewDelegate,SelectedDateTitleViewDelegate,DCindexBtnDelegate,SelectedSaiGuoTitleViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrDataQici;
//@property (nonatomic, strong) NSMutableArray *weekLabArr;
//@property (nonatomic, strong) NSMutableArray *DataLabArr;
//当前页面请求之后保存的flag
@property (nonatomic, assign) NSInteger currentFlag;
@property (nonatomic, assign) NSInteger titleFlag;
//当前选择的日期编号
@property (nonatomic, assign) NSInteger currentdate;
@property (nonatomic, assign) NSInteger titleTemFlag;
@property (nonatomic, strong) UIButton *selectedHeaderBtn;
@property (nonatomic, assign) CGFloat       seletedHeight;

@property (nonatomic, strong) ZBSelectedDataView *dataView;

@property (nonatomic, strong) ZBSelectedDateTitleView *dataTitleView;
@property (nonatomic, strong) ZBSelectedSaiGuoTitleView *saiGuoTitleView;
//@property (nonatomic, strong) ZBHSInfiniteScrollView            *titleScrollView;
@property (nonatomic, assign) CGFloat                         viewSize;

@property (nonatomic, strong) ZBDCindexBtn *indexBtn;
@property (nonatomic, strong) UITableViewCell *seleCell;
//@property (nonatomic, strong) NSMutableArray *weekArr;
//@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView        *dataLineView;

@end

@implementation ZBSaiguoViewController


- (id)init
{
    self = [super init];
    if (self) {
       
//        if (self.titleFlag == 0 || self.titleFlag == 1) {
//            
//            [self.view addSubview:self.saiGuoTitleView];
//            [self.saiGuoTitleView addSubview:self.dataLineView];
//        }
//        if (self.titleFlag == 2 || self.titleFlag == 3) {
        
            [self.view addSubview:self.dataTitleView];
            [self.dataTitleView addSubview:self.dataLineView];
//        }
        
        
        
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.indexBtn];
        
        self.view.backgroundColor = [UIColor whiteColor];
        [[ZBMethods getMainWindow] addSubview:self.dataView];
        [self loadDataQiciJishiViewController];
        
        //设置里面按时间还是联赛顺序排序
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShowType) name:@"NSNotificationchangeShowType" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContenViewTapFresh:) name:biFenTitleChange object:@"biFenChange"];
        //    [ZBLodingAnimateView showLodingView];
  
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
//    [self buildElements];

    self.viewSize = CGRectGetWidth(self.view.bounds) / NUMBER_OF_VISIBLE_VIEWS;
//    [self.titleScrollView reloadDataWithInitialIndex:0];
    

    
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
    // Do any additional setup after loading the view.
    
    self.defaultFailure = @"";
    self.seletedHeight = 60;
    
 
}

- (void)changeShowType
{
    
    if (_currentFlag == 0) {
        [self headerRefreshData];

    }
}
- (void)ContenViewTapFresh:(NSNotification *)noti {
    
    self.titleFlag = (long)[noti.userInfo objectForKey:@"bifenTitleFlag"];
   
    //(long)[noti.userInfo objectForKey:@"bifenTitleFlag"]

}

//- (ZBSelectedDTitleView *)dTitleView {
//
//    if (!_dTitleView) {
//        _dTitleView = [[ZBSelectedDTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, self.seletedHeight)];
//    }
//    return _dTitleView;
//}


/*
- (ZBHSInfiniteScrollView *)titleScrollView {

    if (!_titleScrollView) {
        _titleScrollView = [[ZBHSInfiniteScrollView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, self.seletedHeight)];
    }
    return _titleScrollView;
}



- (void)buildElements {
    
    [self.view addSubview:self.titleScrollView];
    
    
    self.titleScrollView.verticalScroll = NO;
    self.titleScrollView.delegate = self;
    self.titleScrollView.dataSource = self;
    self.titleScrollView.pagingEnabled = NO;
    self.titleScrollView.backgroundColor = colorfbfafa;
    self.titleScrollView.maxScrollDistance = 5;
//    [self.titleScrollView reloadDataWithInitialIndex:0];
    
    [self.titleScrollView scrollToIndex:_arrDataQici.count animated:YES];
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
    
    //    if (view) {
    //        ((UILabel *)view).text = [NSString stringWithFormat:@"周%ld", index];
    //        return view;
    //    }
    
    UIView *baseView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewSize, self.seletedHeight)];
    UILabel *labWeek = [[UILabel alloc] init];
    UILabel *labTime = [UILabel new];
    
    baseView.userInteractionEnabled = YES;
    
//    ZBJSbifenModel *modelJS = [_arrData objectAtIndex:index];
//    ZBQiciModel *model = [_arrDataQici objectAtIndex:index];
//    NSArray *tempWeekArr = self.weekArr.reverseObjectEnumerator.allObjects;
    labWeek.text = [NSString stringWithFormat:@"%@",self.weekArr[index]];
    labWeek.textColor = colorf66666;
    labWeek.font = font14;
    labWeek.textAlignment = NSTextAlignmentCenter;
    
//    NSArray *tempDataArr = self.dataArr.reverseObjectEnumerator.allObjects;
    labTime.text = [NSString stringWithFormat:@"%@",self.dataArr[index]];
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
    
    
    ZBHSDashLineView *lineView = [[ZBHSDashLineView alloc] init];
    lineView.backgroundColor = colorEEEEEE;
    [labWeek addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(baseView);
        make.width.mas_equalTo(1);
    }];
    
//    if (self.weekLabArr.count == 0) {
//        
//        [self.weekLabArr addObject:labWeek];
//    }else{
//        
//        [self.weekLabArr removeAllObjects];
//    }
//    if (self.DataLabArr.count == 0) {
//        
//        [self.DataLabArr addObject:labTime];
//    }else{
//    
//        [self.DataLabArr removeAllObjects];
//    }
    
    return baseView;
}
- (void)scrollView:(ZBHSInfiniteScrollView *)scrollView didScrollToIndex:(NSInteger)index {
    
    NSLog(@"scroll to: %ld", index);
}


# pragma mark - config views -
- (void)configureForegroundOfLabel:(UILabel *)label {
    
    NSString *text = [NSString stringWithFormat:@"%d",(int)label.tag];
    if ([label.text isEqualToString:text]) {
        return;
    }
    label.text = text;
    label.backgroundColor = COLOR;
}

- (void)viewTap: (UIGestureRecognizer *)ges {
    
//    [self.titleScrollView reloadDataWithInitialIndex:ges.view.tag];
    [self ZBSelecterMatchView:nil selectedAtIndex:ges.view.tag WithSelectedName:nil];
}
*/
- (UIView *)dataLineView {

    if (!_dataLineView) {
        _dataLineView = [[UIView alloc] initWithFrame:CGRectMake(0,0, Width, 1)];
        _dataLineView.backgroundColor = colorEEEEEE;
    }
    return _dataLineView;
}

#pragma mark - saiGuoTitleViewDelegate -
- (ZBSelectedSaiGuoTitleView *)saiGuoTitleView {

    if (!_saiGuoTitleView) {
        _saiGuoTitleView = [[ZBSelectedSaiGuoTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, 39)];
//        _saiGuoTitleView.backgroundColor = redcolor;
        _saiGuoTitleView.delegate = self;
    }
    return _saiGuoTitleView;
}

- (void)selectedSaiGuoViewIndex:(NSInteger)index {
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


#pragma mark - dataTitleViewDelegate -
- (ZBSelectedDateTitleView *)dataTitleView
{
    if (!_dataTitleView) {
        _dataTitleView = [[ZBSelectedDateTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, 39)];
//        _dataTitleView.backgroundColor = [UIColor blueColor];
        _dataTitleView.delegate = self;
    }
    return _dataTitleView;
}
//1 中间  2 上一期    3 下一期
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

            if (_arrDataQici.count > 0 ) {
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
        _dataView = [[ZBSelectedDataView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _dataView.alpha = 0;
        _dataView.hidden = YES;
        _dataView.delegate = self;
    }
    return _dataView;
}
/*
- (NSMutableArray *)weekArr{
    
    if (!_weekArr) {
        _weekArr = [NSMutableArray array];
    }
    return _weekArr;
}
- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
*/
- (void)ZBSelecterMatchView:(ZBSelectedDataView *)matchView selectedAtIndex:(NSInteger)index WithSelectedName:(NSString *)name
{
//    [self showOrhideDateView];
    _currentdate = index;
    ZBQiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
    [self loadDataJishiViewControllerWithQici:model];
    [self clearSelectedSaved];
//    if (self.titleFlag == 0 || self.titleFlag == 1) {
//
//        [_saiGuoTitleView setDateIndex:_currentdate];
//    }
//    if (self.titleFlag == 2 || self.titleFlag == 3 ) {
    
        [_dataTitleView setDateIndex:_currentdate];
//    }
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
    // Dispose of any resources that can be recreated.
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
        [_tableView registerClass:[ZBSaiTableViewCell class] forCellReuseIdentifier:cellSaiguoViewController];
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

//Data Source 实现方法
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
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        
        NSDictionary *attributes;
        if (self.arrData.count == 0 ) {
            
            self.defaultFailure = default_noMatch;
//            attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        }else{
        
            attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        }
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (ZBDCindexBtn *)indexBtn
{
    if (!_indexBtn) {
//        _indexBtn = [[ZBDCindexBtn alloc] initWithFrame:CGRectMake(Width - 50, APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29, 50, Height - (APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29 + 49))];
//        _indexBtn.delegate = self;
//        _indexBtn.hidden= YES;
//        //        _indexBtn.backgroundColor = colorTableViewBackgroundColor;
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
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    [self performSelector:@selector(hideIndexBtn) withObject:nil afterDelay:2];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
{
//    [self performSelector:@selector(hideIndexBtn) withObject:nil afterDelay:2];
    
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
//    [self performSelector:@selector(hideIndexBtn) withObject:nil afterDelay:2];

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
    
    
    //        ZBLiveScoreModel *live = [_arrData objectAtIndex:0];
    //        ZBLivingModel *living = [[ZBLivingModel alloc] init];
    //        living.hsc = (int)live.homescore +1;
    //        [self jinqiuShowHudWithLivingModel:living NowModel:live];
    //
    //        [self.tableView.mj_header endRefreshing];
    
    
    if (_arrDataQici.count>0) {
        
        ZBQiciModel *qici = [_arrDataQici objectAtIndex:_currentdate];
        [self loadDataJishiViewControllerWithQici:qici];
    }else{
    
        [self loadDataQiciJishiViewController];
        
    }
    
    [self clearSelectedSaved];

    [self.tableView.mj_header endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (_arrData.count > 0) {
        
        return _arrData.count;
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 39;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    return nil;
//}


/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_arrData.count>0) {
        if (section == _arrData.count-1) {
            
            ZBJSbifenModel *model = [_arrData objectAtIndex:section];
            if (isNUll( model.time)) {
                return 0;
                
            }
        }
        
        ZBJSbifenModel *model = [_arrData objectAtIndex:section];
        if (model.data.count == 0) {
            return 0;
        }
        return 29;
    }
    return 0;
}
 */

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (_arrData.count>0) {
        
        if (section == _arrData.count-1) {
            
            ZBJSbifenModel *model = [_arrData objectAtIndex:section];
            if (isNUll( model.time)) {
                return nil;

            }
            
        }
        
        ZBJSbifenModel *model = [_arrData objectAtIndex:section];
        
        if (model.data.count == 0) {
            return nil;
        }
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 29)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width - 10, 10)];
        lab.textColor = color66;
        lab.font = font10;
        lab.text = [NSString stringWithFormat:@"%@ %ld场",model.time,model.data.count];
        [lab setAttributedText:[ZBMethods withContent:lab.text WithColorText:[NSString stringWithFormat:@"% ld",model.data.count] textColor:redcolor strFont:font10]];
        
        [header addSubview:lab];
        
       
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 28.5, Width, 0.5)];
        line.backgroundColor = colorDD;
        [header addSubview:line];
        return header;
    }
    
    return nil;
}
    
    */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrData.count >0) {
        
        ZBJSbifenModel *model = [_arrData objectAtIndex:section];
        
        return model.data.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZBSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSaiguoViewController];
    if (!cell) {
        cell = [[ZBSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSaiguoViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_arrData.count >0) {
        
        ZBJSbifenModel *model = [_arrData objectAtIndex:indexPath.section];
        cell.ScoreModel = [model.data objectAtIndex:indexPath.row];
    }
    
    cell.contentView.backgroundColor = colorfbfafa;
    
    
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    
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
        
        ZBJSbifenModel *jsmodel = [_arrData objectAtIndex:indexPath.section];
        
        ZBLiveScoreModel *model = [jsmodel.data objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
        return 80;
    }
    return 0;
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
            [arr addObject:model];
            
//            if (model.week) {
//                
//                [self.weekArr addObject:model.week];
//            }
//            if (model.time) {
//                
//                [self.dataArr addObject:model.time];
//            }
            if (model.iscurrent == 1) {
                
                
//            加上当天的比赛
                int j = i + 1;
                
                if (_arrDataQici.count <= j) {
                    break;
                }else{
                    ZBQiciModel * modelToday = [_arrDataQici objectAtIndex:j];
                    [arr addObject:modelToday];
                }

                
                break;
            }
            
        }
        
        //如果没有赛果就显示当前期比赛
        if (arr.count>1) {
            [arr removeLastObject];

        }
        
        //赛果要倒叙排列
        _arrDataQici = [NSMutableArray arrayWithArray:[[arr reverseObjectEnumerator] allObjects]];
//        _arrDataQici = [NSMutableArray arrayWithArray:arr];
        ZBQiciModel *model;
        if (_arrDataQici.count > 0) {
            
            model = [_arrDataQici firstObject];
        }
        _currentdate = 0;
        
        _dataView.arrData = _arrDataQici;
//        if (self.titleFlag == 0 || self.titleFlag == 1) {
//            
//            _dataTitleView.isSaiguo = YES;
//            _dataTitleView.isBeforeTwo = YES;
//            _dataTitleView.arrData = _arrDataQici;
//        }
//        if (self.titleFlag == 2 || self.titleFlag == 3) {
        
//            _dataTitleView.isBeforeTwo = NO;
        _dataTitleView.isSaiguo = YES;
        
        _dataTitleView.arrData = _arrDataQici;
//        }
     
        [self loadDataJishiViewControllerWithQici:model];

        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;

        [self.tableView reloadData];
        [_arrData removeAllObjects];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

    }];
    
    
}

- (void)loadDataJishiViewControllerWithQici:(ZBQiciModel *)model
{
    /*
    NSString *urlStage = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_jsbfnew];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setObject:@(_currentFlag) forKey:@"type"];
    
    */
    NSString *urlJsbf = @"";

    switch (_currentFlag) {
        case 0:
        {
            NSString *urlLeague = @"";
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
                urlLeague = @"league/";
            }
            
            urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_all_result,urlLeague,model.name,url_jsbf_json];
            NSLog(@"%@",urlJsbf);
        }
            break;
        case 1:
        {
            urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_jc_result,model.name,url_jsbf_json];
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
        
//        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
        
        //        NSLog(@"%@",responseOrignal);
        NSMutableArray *arrLoad =[[NSMutableArray alloc] initWithArray:[ZBJSbifenModel arrayOfEntitiesFromArray:[responseOrignal  objectForKey:@"matchs"]]];
                _arrSelectedSaishi = [[NSArray alloc] initWithArray:[ZBBIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal  objectForKey:@"allindex"]]];
                _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[ZBBIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal   objectForKey:@"jcindex"]]];
                _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[ZBBIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal  objectForKey:@"oddsindex"]]];
        
//        //
//        NSMutableArray *arrComplete = [NSMutableArray array];
//        for (int i = 0; i<_memeryArrAllPart.count; i++) {
//            ZBLiveScoreModel *model = [_memeryArrAllPart objectAtIndex:i];
//            
//            if (model.matchstate != 0){
//                
//                for (int j= 0; j<arrLoad.count; j++) {
//                    
//                    ZBLiveScoreModel *loadModel = [arrLoad objectAtIndex:j];
//                    
//                    if (model.mid == loadModel.mid) {
//                        
//                        if (loadModel.matchstate != model.matchstate) {
//                            loadModel.matchstate = model.matchstate;
//                        }
//                        
//                        if (loadModel.homescore < model.homescore) {
//                            loadModel.homescore = model.homescore;
//                        }
//                        if (loadModel.guestscore< model.guestscore) {
//                            loadModel.guestscore = model.guestscore;
//                        }
//                        
//                        if (loadModel.guestRed <model.guestRed) {
//                            loadModel.guestRed = model.guestRed;
//                        }
//                        if (loadModel.homeRed <model.homeRed) {
//                            loadModel.homeRed = model.homeRed;
//                        }
//                        
//                        if (loadModel.guestYellow <model.guestYellow) {
//                            loadModel.guestYellow = model.guestYellow;
//                        }
//                        if (loadModel.homeYellow <model.homeYellow) {
//                            loadModel.homeYellow = model.homeYellow;
//                        }
//                        
//                        
//                        if (![loadModel.matchtime isEqualToString:model.matchtime]) {
//                            loadModel.matchtime = model.matchtime;
//                        }
//                        if (![loadModel.matchtime2 isEqualToString:model.matchtime2]) {
//                            loadModel.matchtime2 = model.matchtime2;
//                        }
//                        
//                        if (!(loadModel.matchstate==0 ||loadModel.matchstate==1 ||loadModel.matchstate==2 ||loadModel.matchstate==3 ||
//                              loadModel.matchstate==4)) {
//                            [arrComplete addObject:loadModel];
//                            
//                        }
//                        
//                        
//                    }
//                }
//            }
//            
//        }
//        
//        
//        for (ZBLiveScoreModel *completeModel in arrComplete) {
//            if ([arrLoad containsObject:completeModel]) {
//                [arrLoad removeObject:completeModel];
//            }
//        }
//        
//        
//        [arrLoad addObjectsFromArray:arrComplete];
        
        
        //         如果是全部的赛事，就把内存中储存的大对阵换掉
//        if(0 == _currentFlag){
        
//        }
        
        
//        //选出完场的比赛
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i<arrLoad.count; i++) {
            ZBJSbifenModel *jsmodel = [arrLoad objectAtIndex:i];
            
            //创建一个和比分数据一样但是为空的model，用来存放筛选过后的数据
            ZBJSbifenModel *sendJs = [[ZBJSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arr addObject:sendJs];
            
            
            for (int m = 0; m<jsmodel.data.count; m++) {
                
                ZBLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                if (model.matchstate == -1 ||model.matchstate == -11 ||model.matchstate == -12 ||model.matchstate == -13 ||model.matchstate == -14 ||model.matchstate ==  -10)
                {
                    [sendJs.data addObject:model];
                }
                
                
            }
        }
        
        
        _arrData = [NSMutableArray arrayWithArray:arr];
        _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arr];

        [self.tableView reloadData];

//    }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];
        [_arrData removeAllObjects];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

    }];
    
    
    
}
// 第一次请求数据的时候清除，因为第一次加载数据的时候清除会把即时比分第一次筛选的赛事清除，即时比分是每次显示页面的时候，当 loadedBifenData 为yes的时候都会加载新的数据，就不会保存选择的赛事了
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
