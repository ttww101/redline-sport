//
//  MyBuyTuijianVC.m
//  GQapp
//
//  Created by WQ on 2017/7/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define cellMyBuyTuijianVC @"cellMyBuyTuijianVC"
#import "MyBuyTuijianVC.h"
#import "TuijianDatingCell.h"
#import "TuijiandatingModel.h"
@interface MyBuyTuijianVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrdata;
@property (nonatomic, assign) NSInteger limitStart;
@end

@implementation MyBuyTuijianVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.defaultFailure = @"";
    [self setNavView];
    [self.view addSubview:self.tableView];
    [self lodaRecommandDataType:loadDataFirst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"购买明细";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
        //right
        
        
    }
}

#pragma mark -- UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[TuijianDatingCell class] forCellReuseIdentifier:cellMyBuyTuijianVC];
        
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self setupHeader];
        [self setupFooter];
    }
    return _tableView;
}

- (void)setupHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataByHeader)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
}
- (void)setupFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataByfooter)];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    self.tableView.mj_footer.hidden = YES;
}
- (void)refreshDataByHeader
{
    [self lodaRecommandDataType:loadDataHeaderRefesh];

 }
- (void)loadMoreDataByfooter
{
    [self lodaRecommandDataType:loadDataMoredata];

 }
//Data Source 实现方法
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrdata.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellMyBuyTuijianVC cacheByIndexPath:indexPath configuration:^(TuijianDatingCell *cell) {
        if (_arrdata.count>0) {
            cell.type = typeTuijianCellMybuy;
            cell.model = [_arrdata objectAtIndex:indexPath.row];
        }
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMyBuyTuijianVC];
    if (!cell) {
        cell = [[TuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMyBuyTuijianVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    cell.type = typeTuijianCellMybuy;
    cell.model = [_arrdata objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)lodaRecommandDataType:(loadDataType)loadType
{
    
    
    
    [self.tableView.mj_footer resetNoMoreData];
    switch (loadType) {
        case loadDataFirst:
        {
            _limitStart = 0;
            _arrdata = [NSMutableArray array];
            //                    [LodingAnimateView showLodingView];
        }
            break;
        case loadDataMoredata:
        {
            _limitStart = _limitStart + 20;
        }
            break;
        case loadDataHeaderRefesh:
        {
            _limitStart = 0;
            _arrdata = [NSMutableArray array];
        }
            break;
            
        default:
            break;
    }

    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)self.userId] forKey:@"userId"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_limitStart] forKey:@"limitStart"];
    [parameter setObject:[NSString stringWithFormat:@"%d",20] forKey:@"limitNum"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_buy_listUser] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        
    } Success:^(id responseResult, id responseOrignal) {
        
        
        
        if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
            self.defaultFailure = @"暂无购买推荐记录";
            NSLog(@"responseOrignal=%@",responseOrignal);
            NSArray *arr = [TuijiandatingModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]];
            
            if (arr.count == 0) {
                if (loadType != loadDataMoredata){
                    _arrdata = [[NSMutableArray alloc] initWithArray:arr];
                }else{
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.tableView reloadData];
            }else{
                
                
                
                [_arrdata addObjectsFromArray:arr];
                
                [self.tableView reloadData];
                
                
            }
        }else{
            if (loadType != loadDataMoredata) {
                [_arrdata removeAllObjects];
            }
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];

        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
        self.defaultFailure =errorDict;
        if (loadType != loadDataMoredata) {
            [_arrdata removeAllObjects];
        }
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

    }];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    
        if (tableView.contentSize.height > tableView.frame.size.height) {
            tableView.mj_footer.hidden = NO;
        }else{
            tableView.mj_footer.hidden = YES;
        }
        
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (tableView.contentSize.height > tableView.frame.size.height) {
            tableView.mj_footer.hidden = NO;
        }else{
            tableView.mj_footer.hidden = YES;
        }
        
    
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
