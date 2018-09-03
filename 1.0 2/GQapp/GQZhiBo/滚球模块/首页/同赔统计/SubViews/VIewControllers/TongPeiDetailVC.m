//
//  TongPeiDetailVC.m
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define cellTongPeiDetailVC @"cellTongPeiDetailVC"
#import "TongPeiDetailVC.h"
#import "TongpeiDetailCell.h"
#import "TongpeiDTResultView.h"
#import "TongpeiDTTitileView.h"
#import "TongPeiSwitch.h"
#import "TitleIndexView.h"
#import "TongpeiDTModel.h"

#import "TongPeiPeiLvDTVC.h"
@interface TongPeiDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,TongPeiSwitchDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TitleIndexView *titleView;
@property (nonatomic, strong) TongpeiDTModel *spfModel;
@property (nonatomic, strong) TongpeiDTModel *yaModel;
@property (nonatomic, strong) TongpeiDTModel *dxModel;
@property (nonatomic, strong) TongpeiDTModel *currentModel;
//0：全部  1：同赛事
@property (nonatomic, assign) NSInteger currentIndex;
//红色的小三角
@property (nonatomic, strong) UIImageView *imageRedAngle;

@end

@implementation TongPeiDetailVC
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
    self.defaultFailure  = @"暂无数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTongpeiDetailData];
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.seletedColor = redcolor;
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.bottomLineColor = [UIColor whiteColor];
    _titleView.nalColor = color33;
    _titleView.arrData = @[@"胜平负",@"亚盘",@"大小球",];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    _imageRedAngle = [[UIImageView alloc] initWithFrame:CGRectMake(Width/3/2 - 17/2, 44 - 9, 17, 9)];
    _imageRedAngle.image = [UIImage imageNamed:@"redAngleTongpei"];
    [_titleView addSubview:_imageRedAngle];
    _imageRedAngle.frame = CGRectMake(Width/3/2 + Width/3*_pelvIndex - 17/2, 44 - 9, 17, 9);

    [_titleView updateSelectedIndex:_pelvIndex];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 0.5)];
    line.backgroundColor = colorCellLine;
    [self.view addSubview:line];

}
- (void)didSelectedAtIndex:(NSInteger)index
{
    _currentIndex = 0;
    switch (index) {
        case 1:
            _currentModel = _yaModel;
            break;
        case 2:
            _currentModel = _dxModel;
            break;
        case 0:
            _currentModel = _spfModel;
            break;

        default:
            break;
    }
    
    _pelvIndex = index;
    _imageRedAngle.frame = CGRectMake(Width/3/2 + Width/3*index - 17/2, 44 - 9, 17, 9);
    
    [self.tableView reloadData];
}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = isNUll(_currentModel.all.homeTeam)?@"同赔指数详情": [NSString stringWithFormat:@"%@ vs %@",_currentModel.all.homeTeam,_currentModel.all.guestTeam] ;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[TongpeiDetailCell class] forCellReuseIdentifier:cellTongPeiDetailVC];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = [UIColor whiteColor]
        ;        [self setupTableViewMJHeader];
    }
    return _tableView;
}

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 0;
//    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 185 - 40)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *labTitle  = [[UILabel alloc] init];
    labTitle.font = font12;
    labTitle.textColor = color33;
//    [header addSubview:labTitle];
//    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(header.mas_left).offset(15);
//        make.top.equalTo(header.mas_top).offset(12.5);
//    }];
    

    
    labTitle.text = _currentIndex == 0? [NSString stringWithFormat:@"%@初赔%@%@%@,同赔指数结果",_currentModel.all.company,_currentModel.all.win,_currentModel.all.draw,_currentModel.all.lose] : [NSString stringWithFormat:@"%@初赔%@%@%@,同赔指数结果",_currentModel.same.company,_currentModel.same.win,_currentModel.same.draw,_currentModel.same.lose];
    

    
    
    
    UIView *viewDetail = [[UIView alloc] init];
//    viewDetail.backgroundColor = colorTableViewBackgroundColor;
    [header addSubview:viewDetail];
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(header.mas_top).offset(12.5);
        make.size.mas_equalTo(CGSizeMake(Width, 35));
    }];
    
    TongpeiDTResultView *resultView = [[TongpeiDTResultView alloc] initWithFrame:CGRectMake(0, 0, Width, 35)];
    resultView.type = _currentIndex;
    resultView.model = _currentIndex == 0? _currentModel.all : _currentModel.same;
    [viewDetail addSubview:resultView];
    
    
    UILabel *labDetail = [[UILabel alloc] init];
    labDetail.textColor = color33;
    labDetail.font = font12;
    [header addSubview:labDetail];
    [labDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.top.equalTo(viewDetail.mas_bottom).offset(35.5);
    }];
    labDetail.text = @"历史样本详情";
    
    
    TongPeiSwitch *btnSwitch = [[TongPeiSwitch alloc] init];
    btnSwitch.delegate = self;
    [btnSwitch setSelectedIndex:_currentIndex];
    [header addSubview:btnSwitch];
    [btnSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(header.mas_right).offset(-15);
        make.centerY.equalTo(labDetail.mas_centerY);
        make.size.mas_offset(CGSizeMake(120, 29));
    }];
    
    
    UIView *viewListTitle = [[UIView alloc] init];
//    viewListTitle.backgroundColor = colorTableViewBackgroundColor;
    [header addSubview:viewListTitle];
    [viewListTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(labDetail.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(Width, 30));
    }];
    
    
    if (_currentIndex == 0) {
        if (_currentModel.all.matchs.count == 0) {
            labTitle.text = @"同赔指数结果";
            
        }else{
            TongpeiDTTitileView *titleView = [[TongpeiDTTitileView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
            [viewListTitle addSubview:titleView];

        }
    }
    
    if (_currentIndex == 1) {
        if (_currentModel.same.matchs.count == 0) {
            labTitle.text = @"同赔指数结果";
            
        }else{
        
            TongpeiDTTitileView *titleView = [[TongpeiDTTitileView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
            [viewListTitle addSubview:titleView];

        }
    }

    
    
    
    return header;
    return nil;
}
- (void)didSelectedIndex:(NSInteger )index
{
    _currentIndex = index;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 0;
//    }
    return 185 - 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 0;
    //    }
    return 0.000001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 0;
//    }
    return _currentIndex == 0? _currentModel.all.matchs.count :_currentModel.same.matchs.count  ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return 0;
//    }

    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return [UITableViewCell new];
//    }

    TongpeiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTongPeiDetailVC];
    if (!cell) {
        cell = [[TongpeiDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTongPeiDetailVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
//    cell.textLabel.text = @"cell";
    cell.pelvIndex = _pelvIndex;
    cell.model =_currentIndex == 0? [_currentModel.all.matchs objectAtIndex:indexPath.row] : [_currentModel.same.matchs objectAtIndex:indexPath.row];
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TongPeiPeiLvDTVC *tongPDT = [[TongPeiPeiLvDTVC alloc] init];
//    tongPDT.hidesBottomBarWhenPushed = YES;
//    [APPDELEGATE.customTabbar pushToViewController:tongPDT animated:YES];

}

- (void)loadTongpeiDetailData
{
    [[DependetNetMethods sharedInstance] requestSameOdd_detailWithscheduleId:[NSString stringWithFormat:@"%ld",_scheduleId] WithsclassId:[NSString stringWithFormat:@"%ld",_sclassId] Start:^(id requestOrignal) {
        
        [LodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        
    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] intValue]== 200) {
            
            
            _spfModel = [TongpeiDTModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"spf"]];
            _dxModel = [TongpeiDTModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"dx"]];
            _yaModel = [TongpeiDTModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"ya"]];
            
            switch (_pelvIndex) {
                case 1:
                    _currentModel = _yaModel;

                    break;
                case 2:
                    _currentModel = _dxModel;
                    
                    break;
                case 0:
                    _currentModel = _spfModel;
                    
                    break;

                default:
                    break;
            }
            
            [self.tableView reloadData];
        }
        [self setNavView];
        [self.view addSubview:self.tableView];

        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [self setNavView];
        self.defaultFailure  = errorDict;

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
