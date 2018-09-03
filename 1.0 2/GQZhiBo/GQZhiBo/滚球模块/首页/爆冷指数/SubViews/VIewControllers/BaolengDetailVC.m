//
//  BaolengDetailVC.m
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define cellBaolengDetailVC @"cellBaolengDetailVC"
#import "BaolengDetailVC.h"
#import "BaolengDTHeaderView.h"
#import "BaolengSwitch.h"
#import "BaolengDTcell.h"
#import "BaolengDTTitleView.h"
#import "BaolengDetailModel.h"
@interface BaolengDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,BaolengSwitchDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BaolengDetailModel*baolengModel;
@property (nonatomic, strong) BaolengDetailModel*leaguecoldinfo;
@property (nonatomic, strong) BaolengDetailModel*historycoldinfo;
@property (nonatomic, strong) BaolengDetailModel*allcoldinfo;

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation BaolengDetailVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = isNUll(_allcoldinfo.body.teamname)?@"统计明细": [NSString stringWithFormat:@"%@ vs %@",_allcoldinfo.body.hometeam,_allcoldinfo.body.guestteam] ;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.defaultFailure = @"暂无数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self.view addSubview:self.tableView];
    [self loadBaolengDetailData];
}

#pragma mark -- UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[BaolengDTcell class] forCellReuseIdentifier:cellBaolengDetailVC];
        
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return _tableView;
}

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 0;
    //    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 195)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *labTitle  = [[UILabel alloc] init];
    labTitle.font = font12;
    labTitle.textColor = color33;
    [header addSubview:labTitle];
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.top.equalTo(header.mas_top).offset(12.5);
    }];
    labTitle.text =@"" ;
    
    UIView *viewDetail = [[UIView alloc] init];
//    viewDetail.backgroundColor = colorTableViewBackgroundColor;
    [header addSubview:viewDetail];
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(labTitle.mas_bottom).offset(17.5);
        make.size.mas_equalTo(CGSizeMake(Width, 45));
    }];
    
    BaolengDTHeaderView *baolengDT = [[BaolengDTHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
    baolengDT.model = _baolengModel.body;
    [viewDetail addSubview:baolengDT];
    
    
    
    
    
    UILabel *labDetail = [[UILabel alloc] init];
    labDetail.textColor = color33;
    labDetail.font = font12;
    [header addSubview:labDetail];
    [labDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.top.equalTo(viewDetail.mas_bottom).offset(35.5);
    }];
    labDetail.text = [NSString stringWithFormat:@"历史爆冷%ld场",_baolengModel.body.num];
    
    
    
    BaolengSwitch *btnSwitch = [[BaolengSwitch alloc] init];
    btnSwitch.delegate = self;
    [btnSwitch setSelectedIndex:_currentIndex];
    [header addSubview:btnSwitch];
    [btnSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(header.mas_right).offset(-15);
        make.centerY.equalTo(labDetail.mas_centerY);
        make.size.mas_offset(CGSizeMake(180, 29));
    }];

    
    
    UIView *viewListTitle = [[UIView alloc] init];
//        viewListTitle.backgroundColor = colorTableViewBackgroundColor;
    [header addSubview:viewListTitle];
    [viewListTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(labDetail.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(Width, 30));
    }];
    
    if (_baolengModel.list.count != 0) {
        BaolengDTTitleView *titleV = [[BaolengDTTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
        [viewListTitle addSubview:titleV];

    }
    
    return header;
    return nil;
}
- (void)didSelectedBaolengSwitchIndex:(NSInteger )index
{
    _currentIndex = index;
    switch (index) {
        case 0:
        {
            _baolengModel = _allcoldinfo;
        }
            break;
        case 1:
        {
            _baolengModel = _leaguecoldinfo;
        }
            break;
        case 2:
        {
            _baolengModel = _historycoldinfo;
        }
            break;

        default:
            break;
    }
    
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 0;
    //    }
    return 195;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _baolengModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaolengDTcell *cell = [tableView dequeueReusableCellWithIdentifier:cellBaolengDetailVC];
    if (!cell) {
        cell = [[BaolengDTcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBaolengDetailVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    cell.model = [_baolengModel.list objectAtIndex:indexPath.row];
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)loadBaolengDetailData
{
    [[DependetNetMethods sharedInstance] requestSurpriseWithType:[NSString stringWithFormat:@"%ld",_idId] Start:^(id requestOrignal) {
        [LodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];

    } Success:^(id responseResult, id responseOrignal) {
        
        if ([responseOrignal objectForKey:@"code"]) {
            
            _leaguecoldinfo = [BaolengDetailModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"leaguecoldinfo"]];
            _historycoldinfo = [BaolengDetailModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"historycoldinfo"]];
            _allcoldinfo = [BaolengDetailModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"allcoldinfo"]];
            _baolengModel = _allcoldinfo;
            [self setNavView];
            [self.tableView reloadData];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
