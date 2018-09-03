//
//  ZBBetTingTableView.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/6.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBetTingTableView.h"
#import "ZBBettingCell.h"
#import "ZBTouZhuModel.h"
#import "ZBFenxiPageVC.h"
#import "ZBZhiboTableView.h"
@interface ZBBetTingTableView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, assign)BOOL isToFenxi;
@property (nonatomic, strong)ZBBettingCell *seleCell;
@end


@implementation ZBBetTingTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self == [super initWithFrame:frame style:style]) {
        _isToFenxi = NO;
        self.defaultTitle = @"";
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource  = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.showsVerticalScrollIndicator = NO;
        [self setupTableViewMJHeader];
    }
    return self;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//    }];
//    footer.automaticallyHidden = YES;
//    self.mj_footer = footer;
//    self.mj_footer.hidden = YES;
    
}

- (void)setArrData:(NSArray *)arrData{
    _arrData = arrData;
    [self reloadData];
}
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if ([self.defaultTitle isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    if ([self.defaultTitle isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    NSString *text = self.defaultTitle;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.arrData.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.arrData.count == 0) {
        return 0;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.arrData.count == 0) {
        return [UIView new];
    }
    UIView *basView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    basView.backgroundColor = [UIColor whiteColor];
    
    UILabel *labOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 30)];
    labOne.font = font12;
    labOne.textColor = color99;
    labOne.text = @"比赛";
    [basView addSubview:labOne];
    
    UILabel *labBiLi = [[UILabel alloc] initWithFrame:CGRectMake(Width - 40, 0, 40 , 30)];
    labBiLi.font = font12;
    labBiLi.textColor = color99;
    labBiLi.text = @"误差";
    labBiLi.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labBiLi];
    
    UILabel *labJY = [[UILabel alloc] initWithFrame:CGRectMake(Width - 80, 0, 40, 30)];
    labJY.font = font12;
    labJY.textColor = color99;
    labJY.text = @"投注比";
    labJY.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labJY];
    
    UILabel *labCj = [[UILabel alloc] initWithFrame:CGRectMake(Width - 115, 0, 35, 30)];
    labCj.font = font12;
    labCj.textColor = color99;
    labCj.text = @"概率";
    labCj.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labCj];
    
    UILabel *labPL = [[UILabel alloc] initWithFrame:CGRectMake(Width - 155, 0, 40, 30)];
    labPL.font = font12;
    labPL.textColor = color99;
    labPL.text = @"赔率";
    labPL.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labPL];
    
    
    UIView *lienView = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, Width, 0.5)];
    lienView.backgroundColor = colorDD;
    [basView addSubview:lienView];
    
    return basView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"acell";
    ZBBettingCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[ZBBettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    //    //    cell.type = self.typeNum;
    
    cell.model = self.arrData[indexPath.row];
    
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZBTouZhuModel *model = self.arrData[indexPath.row];
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:@(model.sid) forKey:@"sid"];
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            ZBLiveScoreModel *model = [ZBLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            //从首页跳转分析页的时候不用反转
            model.neutrality = NO;
            ZBFenxiPageVC *fenxiVC = [[ZBFenxiPageVC alloc] init];
            fenxiVC.segIndex = 4;
            fenxiVC.model = model;
            fenxiVC.currentIndex = 1;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            
        }
        _isToFenxi = NO;
        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
        
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
    
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    _seleCell=[self cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
