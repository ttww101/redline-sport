//
//  TongPeiPeiLvDTVC.m
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define cellTongpeiHistory @"TongpeiHistoryCell"
#define cellTongpeiPeilvChange @"cellTongpeiPeilvChange"
#import "TongPeiPeiLvDTVC.h"
#import "TongpeiHistoryCell.h"
#import "TongpeiPeilvChangeCell.h"
#import "TongpeiPeilvChangeTItleView.h"
@interface TongPeiPeiLvDTVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TongPeiPeiLvDTVC
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
    [self setNavView];
    [self.view addSubview:self.tableView];
}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"Bet365赔率详情";
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[TongpeiHistoryCell class] forCellReuseIdentifier:cellTongpeiHistory];
        [_tableView registerClass:[TongpeiPeilvChangeCell class] forCellReuseIdentifier:cellTongpeiPeilvChange];

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
    NSString *text = @"暂无直播";
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 62)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 42)];
        labTitle.textColor = color33;
        labTitle.font = font12;
        labTitle.text = @"历史同赔";
        [header addSubview:labTitle];
        
        for (int i = 0; i<4; i++) {
            
            UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(Width/4*i, 42, Width/4, 20)];
            labT.font = font12;
            labT.textColor = color99;
            labT.textAlignment = NSTextAlignmentCenter;
            switch (i) {
                case 0:
                    labT.text = @"赛事";
                    break;
                case 1:
                    labT.text = @"主队";
                    break;
                case 2:
                    labT.text = @"走盘";
                    break;
                case 3:
                    labT.text = @"客队";
                    break;

                default:
                    break;
            }
            [header addSubview:labT];
            
        }
        
        return header;
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 70)];
    header.backgroundColor = [UIColor whiteColor];

    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 35)];
    labTitle.textColor = color33;
    labTitle.font = font12;
    labTitle.text = @"赔率变化";
    [header addSubview:labTitle];

    TongpeiPeilvChangeTItleView *viewListTitle = [[TongpeiPeilvChangeTItleView alloc] initWithFrame:CGRectMake(0, labTitle.bottom, Width, 30)];
//    viewListTitle.backgroundColor = colorTableViewBackgroundColor;
    [header addSubview:viewListTitle];
    
    
    return header;

    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 62;
    }else if (section == 1){
        return 70;
    }
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
        
        footer.backgroundColor = [UIColor whiteColor];

        UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMore.frame = CGRectMake(0, 0, 120, 29);
        btnMore.center = footer.center;
        btnMore.titleLabel.font = font12;
        [btnMore setTitle:@"查看统计明细>>" forState:UIControlStateNormal];
        [btnMore setTitleColor:color33 forState:UIControlStateNormal];
        [btnMore addTarget:self action:@selector(btnMoreClick:) forControlEvents:UIControlEventTouchUpInside];
        btnMore.layer.borderColor = colorDD.CGColor;
        btnMore.layer.borderWidth = 0.5;
        [footer addSubview:btnMore];
        return footer;

    }
    return nil;
}
- (void)btnMoreClick:(UIButton *)btn
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 49;
    }else{
        return 0.0001;

    }
    return 0.0001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 45;
    }
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        TongpeiHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTongpeiHistory];
        if (!cell) {
            cell = [[TongpeiHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTongpeiHistory];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.data = @"";
        return cell;

        
    }
    
    
    TongpeiPeilvChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTongpeiPeilvChange];
    if (!cell) {
        cell = [[TongpeiPeilvChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTongpeiPeilvChange];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    cell.data = @"";
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
