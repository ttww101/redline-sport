//
//  SaichengViewController.m
//  GQapp
//
//  Created by WQ on 2016/12/21.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#define  cellSaichengViewController @"cellSaichengViewController"
#import "SaiTableViewCell.h"
#import "LiveScoreModel.h"
#import "QiciModel.h"
#import "BIfenSelectedSaishiModel.h"
#import "JSbifenModel.h"

#import "SaichengViewController.h"
#import "SelectedDataView.h"
#import "SelectedDateTitleView.h"
#import "DCindexBtn.h"
#import "HSInfiniteScrollView.h"

#define NUMBER_OF_VISIBLE_VIEWS 5

@interface SaichengViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,SelecterDateViewDelegate,SelectedDateTitleViewDelegate,DCindexBtnDelegate,HSInfiniteScrollViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrDataQici;
//当前页面请求之后保存的flag
@property (nonatomic, assign) NSInteger currentFlag;
//当前选择的日期编号
@property (nonatomic, assign) NSInteger currentdate;

@property (nonatomic, assign) NSInteger currentSeleData;
@property (nonatomic, assign) NSInteger titleViewFlag;
@property (nonatomic, strong) SelectedDataView *dataView;

@property (nonatomic, assign) CGFloat       seletedHeight;
@property (nonatomic, strong) NSMutableArray        *timeArr;

@property (nonatomic, strong) UIButton *selectedHeaderBtn;
@property (nonatomic, strong) SelectedDateTitleView *dataTitleView;
@property (nonatomic, strong) HSInfiniteScrollView            *titleScrollView;
@property (nonatomic, assign) CGFloat                         viewSize;

@property (nonatomic, strong) DCindexBtn *indexBtn;
@property (nonatomic, strong) UITableViewCell *seleCell;
@property (nonatomic, strong) UIView        *dataLineView;


@end

@implementation SaichengViewController


- (id)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.dataTitleView];
        [self.dataTitleView addSubview:self.dataLineView];
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.indexBtn];

        self.view.backgroundColor = [UIColor whiteColor];
        
        [[Methods getMainWindow] addSubview:self.dataView];
        
        [self loadDataQiciJishiViewController];
        
        //设置里面按时间还是联赛顺序排序
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShowType) name:@"NSNotificationchangeShowType" object:nil];
        
        //    [LodingAnimateView showLodingView];

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
    // Do any additional setup after loading the view.
    self.defaultFailure = @"";
    self.seletedHeight = 60;
    [self buildElements];

}

- (void)biFenChange:(NSNotification *)dict {
    
    _titleViewFlag = (NSInteger)dict.userInfo[@"bifenTitleFlag"];
//    if (_titleViewFlag == 1 || _titleViewFlag == 2) {
//        
//        [self.titleScrollView reloadDataWithInitialIndex:_titleViewFlag];
//    }

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


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    
//    if([keyPath isEqualToString:@"titleFlag"]) {
//        
//        NSLog(@"%@",[change valueForKey:@"new"]);
//    }
//    
//    //    NSString *ageStr = [[[NSNumberFormatter alloc] init] stringFromNumber:[change objectForKey:@"new"]];
//    
//}


- (void)buildElements {
    
//    if (_titleViewFlag == 0 || _titleViewFlag == 2) {
//    
//        [self.view addSubview:self.titleScrollView];
////        self.titleScrollView.delegate = self;
//        self.titleScrollView.verticalScroll = NO;
//        self.titleScrollView.dataSource = self;
//        self.titleScrollView.pagingEnabled = NO;
//        self.titleScrollView.maxScrollDistance = 5;
//    }else{  //(self.titleViewFlag == 3 || self.titleViewFlag == 4)
//
        [self.view addSubview:self.dataTitleView];
//    }
}

# pragma mark - HSInfiniteScrollView dataSource
- (NSInteger)numberOfViews {
    
    return _arrDataQici.count;
}

- (NSInteger)numberOfVisibleViews {
    
    return NUMBER_OF_VISIBLE_VIEWS;
}

# pragma mark - HSInfiniteScrollView delegate -
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
//    if (view) {
//        ((UILabel *)view).text = [NSString stringWithFormat:@"周%ld", index];
//        return view;
//    }
    
    UIView *baseView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewSize, self.seletedHeight)];
    UILabel *labWeek = [[UILabel alloc] init];
    UILabel *labTime = [UILabel new];

    baseView.userInteractionEnabled = YES;
    
//    JSbifenModel *modelJS = [_arrData objectAtIndex:index];
    QiciModel *model = [_arrDataQici objectAtIndex:index];
    
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
- (void)scrollView:(HSInfiniteScrollView *)scrollView didScrollToIndex:(NSInteger)index {
    
    NSLog(@"scroll to: %ld", index);
}

/*
 # pragma mark - config views -
 - (void)configureForegroundOfLabel:(UILabel *)label {
 
 NSString *text = [NSString stringWithFormat:@"%d",(int)label.tag];
 if ([label.text isEqualToString:text]) {
 return;
 }
 label.text = text;
 }
 */

- (void)viewTap: (UIGestureRecognizer *)ges {
    
//    [self.titleScrollView reloadDataWithInitialIndex:ges.view.tag];
    [self SelecterMatchView:nil selectedAtIndex:ges.view.tag WithSelectedName:nil];
}

- (HSInfiniteScrollView *)titleScrollView {
    
    if (!_titleScrollView) {
        _titleScrollView = [[HSInfiniteScrollView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, self.seletedHeight)];
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

- (SelectedDateTitleView *)dataTitleView
{
    if (!_dataTitleView) {
        _dataTitleView = [[SelectedDateTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, 60 / 2 + 9)];
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
            
            if (_arrDataQici.count > 0) {
                
                QiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
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
                
                QiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
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

- (SelectedDataView *)dataView
{
    if (!_dataView) {
        _dataView = [[SelectedDataView alloc] initWithFrame:CGRectMake(0, 0, Width, Height )];
        _dataView.alpha = 0;
        _dataView.hidden = YES;
        _dataView.delegate = self;
    }
    return _dataView;
}

- (void)SelecterMatchView:(SelectedDataView *)matchView selectedAtIndex:(NSInteger)index WithSelectedName:(NSString *)name
{
//    if (self.titleViewFlag == 3 || self.titleViewFlag == 4) {
    
        [self showOrhideDateView];
//    }
    
    _currentdate = index;
    QiciModel *model  = [_arrDataQici objectAtIndex:_currentdate];
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
        [_tableView registerClass:[SaiTableViewCell class] forCellReuseIdentifier:cellSaichengViewController];
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
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes;
        if (self.arrData.count == 0) {
//            attributes= @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
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
//是否允许滚动 (默认是 NO) :
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

- (DCindexBtn *)indexBtn
{
    if (!_indexBtn) {
//        _indexBtn = [[DCindexBtn alloc] initWithFrame:CGRectMake(Width - 50, APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29, 50, Height - (APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29 + 49))];
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
    
    
    //        LiveScoreModel *live = [_arrData objectAtIndex:0];
    //        LivingModel *living = [[LivingModel alloc] init];
    //        living.hsc = (int)live.homescore +1;
    //        [self jinqiuShowHudWithLivingModel:living NowModel:live];
    //
    //        [self.tableView.mj_header endRefreshing];
    
    
    if (_arrDataQici.count>0) {
        
        QiciModel *qici = [_arrDataQici objectAtIndex:_currentdate];
        
        [self loadDataJishiViewControllerWithQici:qici];
    }else{
        
        [self loadDataQiciJishiViewController];
        
    }
    [self clearSelectedSaved];

    [self.tableView.mj_header endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_arrData) { // .firstObject
        return _arrData.count;
    }
    return 0;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_arrData.count>0) {
        if (section == _arrData.count-1) {
            JSbifenModel *model = [_arrData objectAtIndex:section];
            if (isNUll( model.time)) {
                return 0;
                
            }
        }
        
        JSbifenModel *model = [_arrData objectAtIndex:section];
        if (model.data.count == 0) {
            return 0;
        }
        return 29;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    section = self.currentSeleData;
    
    if (_arrData.count>0) {
        
        if (section == _arrData.count-1) {
            JSbifenModel *model = [_arrData objectAtIndex:section];
            if (isNUll( model.time)) {
                return nil;
                
            }
        }
        
        JSbifenModel *model = [_arrData objectAtIndex:section];
        
        if (model.data.count == 0) {
            return nil;
        }
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 29)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width - 10, 10)];
        lab.textColor = color66;
        lab.font = font10;
        lab.text = [NSString stringWithFormat:@"%@ %ld场",model.time,model.data.count];
        [lab setAttributedText:[Methods withContent:lab.text WithColorText:[NSString stringWithFormat:@"% ld",model.data.count] textColor:redcolor strFont:font10]];
        
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
    if (_arrData.count > 0 ) {
        
        JSbifenModel *model = [_arrData objectAtIndex:section];
        
        return model.data.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSaichengViewController];
    if (!cell) {
        cell = [[SaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSaichengViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = colorfbfafa;
    JSbifenModel *model;
    if (_arrData.count > 0) {
        
         model = [_arrData objectAtIndex:indexPath.section];
        
        cell.ScoreModel = [model.data objectAtIndex:indexPath.row];
    }
    
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    
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
    LiveScoreModel *model;
    if (_arrData.count > 0) {
        
        JSbifenModel *jsmodel = [_arrData objectAtIndex:indexPath.section];
        
        model = [jsmodel.data objectAtIndex:indexPath.row];
    }
    if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
        return 108;
    }
    return 80;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (_arrDataQici.count == 0) {
//        return 0;
//    }
//    return 42;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (_arrDataQici.count == 0) {
//        
//        return nil;
//        
//    }else{
//        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 42)];
//        view.backgroundColor = [UIColor whiteColor];
//        
//        for (int i = 0; i<_arrDataQici.count; i++) {
//            
//            QiciModel *model = [_arrDataQici objectAtIndex:i];
//            
//            if (_currentFlag == 0 || _currentFlag == 1) {
//                CGFloat btnwidth = 30;
//                CGFloat btnheight = 30;
//                CGFloat btnspace = (Width- btnwidth*_arrDataQici.count)/(_arrDataQici.count + 1);
//                
//                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                btn.frame = CGRectMake(btnspace *(i+1)+ btnwidth*i, 9/2, btnheight, btnwidth);
//                btn.tag = i;
//                btn.titleLabel.numberOfLines = 2;
//                btn.layer.cornerRadius = btn.width/2;
//                btn.layer.masksToBounds = YES;
//                NSArray *arrNowdate;
//                if (_currentFlag == 1) {
//                    arrNowdate = [Methods getDateByDate:[Methods getDateFromString:model.name byformat:@"yyyyMMdd"] withWeekType:weekTypeZhou];
//                    
//                }else{
//                    arrNowdate = [Methods getDateByDate:[Methods getDateFromString:model.name byformat:@"yyyy-MM-dd"] withWeekType:weekTypeZhou];
//                    
//                }
//                
//                NSString *titleDay = [NSString stringWithFormat:@"%@",[arrNowdate objectAtIndex:2]];
//                if (titleDay.length == 1) {
//                    titleDay = [NSString stringWithFormat:@"0%@",titleDay];
//                }
//                NSString *titleWeek = [arrNowdate objectAtIndex:4];
//                [btn setTitle:[NSString stringWithFormat:@" %@\n%@",titleDay,titleWeek] forState:UIControlStateNormal];
//                [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//                [btn setTitleColor:color74 forState:UIControlStateNormal];
//                
//                [btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateSelected];
//                [btn setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
//                if (btn.tag == _currentdate) {
//                    btn.selected = YES;
//                    _selectedHeaderBtn = btn;
//                }else{
//                    btn.selected = NO;
//                }
//                btn.titleLabel.font = font8;
//                [btn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [view addSubview:btn];
//                
//                
//            }else if (_currentFlag == 2 || _currentFlag == 3){
//                
//                CGFloat btnheight = 39;
//                CGFloat btnwidth = Width/_arrDataQici.count;
//                
//                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnwidth*i, 0, btnwidth, btnheight)];
//                btn.tag = i;
//                [btn setTitle:model.name forState:UIControlStateNormal];
//                [btn setTitleColor:color74 forState:UIControlStateNormal];
//                [btn setTitleColor:redcolor forState:UIControlStateSelected];
//                
//                if ( i == _currentdate)
//                {
//                    btn.selected = YES;
//                }else{
//                    btn.selected = NO;
//                }
//                btn.titleLabel.font = font11;
//                [btn addTarget:self action:@selector(headerQiciBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [view addSubview:btn];
//                
//            }
//        }
//        
//        if (_arrDataQici.count>0) {
//            
//            UIView *viewLineTop  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
//            viewLineTop.backgroundColor = colorTableViewBackgroundColor;
//            [view addSubview:viewLineTop];
//            
//            
//            UIView *viewLine  = [[UIView alloc] initWithFrame:CGRectMake(0, 39, Width, 3)];
//            viewLine.backgroundColor = colorTableViewBackgroundColor;
//            [view addSubview:viewLine];
//            
//        }
//        
//        return view;
//    }
//}




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
    
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:urlStage Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        _arrDataQici = [[NSMutableArray alloc] initWithArray:[QiciModel arrayOfEntitiesFromArray:responseOrignal]];
        if (_arrDataQici.count == 0) {
            [_arrData removeAllObjects];
            [self.tableView reloadData];
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int i = 0; i<_arrDataQici.count; i++) {
            QiciModel *model = [_arrDataQici objectAtIndex:i];
            if (model.iscurrent == 1) {
//                int j = i - 1;
//                
//                if (_arrDataQici.count < j) {
//                    break;
//                }else{
//                    QiciModel * modelToday = [_arrDataQici objectAtIndex:j];
//                    [arr addObject:modelToday];
//                }

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

        QiciModel *model = [_arrDataQici objectAtIndex:0];
        _currentdate = 0;
        [self loadDataJishiViewControllerWithQici:model];

        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;

        [_arrData removeAllObjects];
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

    }];
    
    
}

- (void)loadDataJishiViewControllerWithQici:(QiciModel *)model
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
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:urlJsbf Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        //        NSLog(@"%@",responseOrignal);
        NSMutableArray *arrLoad =[[NSMutableArray alloc] initWithArray:[JSbifenModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"matchs"]]];
                _arrSelectedSaishi = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"allindex"]]];
                _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"jcindex"]]];
                _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"oddsindex"]]];
        
//        //
//        NSMutableArray *arrComplete = [NSMutableArray array];
//        for (int i = 0; i<_memeryArrAllPart.count; i++) {
//            LiveScoreModel *model = [_memeryArrAllPart objectAtIndex:i];
//            
//            if (model.matchstate != 0){
//                
//                for (int j= 0; j<arrLoad.count; j++) {
//                    
//                    LiveScoreModel *loadModel = [arrLoad objectAtIndex:j];
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
//        for (LiveScoreModel *completeModel in arrComplete) {
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
        
        
//        选出未开始的比赛，其余的比赛不在赛程里面展示
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i<arrLoad.count; i++) {
            JSbifenModel *jsmodel = [arrLoad objectAtIndex:i];
            
            //创建一个和比分数据一样但是为空的model，用来存放筛选过后的数据
            JSbifenModel *sendJs = [[JSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arr addObject:sendJs];
            
            
            for (int m = 0; m<jsmodel.data.count; m++) {
                
                LiveScoreModel *model = [jsmodel.data objectAtIndex:m];
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




// 第一次请求数据的时候清除，因为第一次加载数据的时候清除会把即时比分第一次筛选的赛事清除，即时比分是每次显示页面的时候，当 loadedBifenData 为yes的时候都会加载新的数据，就不会保存选择的赛事了
- (void)clearSelectedSaved
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    NSString *documentPath = [Methods getDocumentsPath];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
