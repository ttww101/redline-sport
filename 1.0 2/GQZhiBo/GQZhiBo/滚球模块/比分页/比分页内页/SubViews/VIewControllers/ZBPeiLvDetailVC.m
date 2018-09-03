//
//  ZBPeiLvDetailVC.m
//  GQapp
//
//  Created by Marjoice on 09/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBPeiLvDetailVC.h"
#import "ZBHSTabBarContentView.h"
#import "ZBPeiLvDetailModel.h"
#import "ZBPeiLvDetailTableVC.h"
#import "ZBJiShiPeiLvDetailModel.h"

@interface ZBPeiLvDetailVC ()<HSTabBarContentViewDelegate,HSTabBarContentViewDataSource>
@property (nonatomic, strong) ZBHSTabBarContentView               *tabBarContentView;
@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, strong) ZBNavView                           *nav;
@property (nonatomic, strong) NSMutableArray                    *titleArr;
@property (nonatomic, strong) NSMutableArray                    *jiaoqiutitleArr;
@property (nonatomic, strong) NSMutableArray                    *peiLvDetailArr;

@end
@implementation ZBPeiLvDetailVC

- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorTableViewBackgroundColor;

    [self setupMainCategories];
    [self setNavView];
}

#pragma mark - SetNavView -
- (void)setNavView{
   
    _nav = [[ZBNavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = [NSString stringWithFormat:@"%@ vs %@",_model.hometeam,_model.guestteam];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    
    [self.view addSubview:_nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index {
    if (index == 1) {
        //left
    
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        //right
        
    }
}

- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"全场让球",@"半场让球",@"全场大小",@"半场大小", nil];
    }
    return _titleArr;
}

- (NSMutableArray *)jiaoqiutitleArr {
    
    if (!_jiaoqiutitleArr) {
        _jiaoqiutitleArr = [NSMutableArray arrayWithObjects:@"角球让分",@"角球大小", nil];
    }
    return _jiaoqiutitleArr;
}

- (ZBHSTabBarContentView *)tabBarContentView {
    
    if (!_tabBarContentView) {
        _tabBarContentView = [[ZBHSTabBarContentView alloc] init];
        _tabBarContentView.dataSource = self;
        _tabBarContentView.delegate = self;
        _tabBarContentView.backgroundColor = [UIColor whiteColor];
    }
    return _tabBarContentView;
}

- (void)setupMainCategories {
    
    [self.view addSubview:self.tabBarContentView];
    [self.tabBarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(_TabBarHeight + _StatusBarHeight - 5);
        make.width.mas_equalTo(Width);
        make.bottom.equalTo(self.view);
        make.trailing.mas_equalTo(self.view).offset(0);
        make.leading.mas_equalTo(self.view).offset(0);
    }];
    [self.tabBarContentView reloadData];
}

- (void)setupTableViewMJHeader {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}

#pragma mark - HSTabBarContentViewDataSource -
- (NSInteger)numberOfItemsInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView {
    
    if (self.PeiLvCType == isBeforeTwo) {
        
        return self.titleArr.count;
    }else{
    
        return self.jiaoqiutitleArr.count;
    }
    return 0;
}

- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView {
    
    if (self.PeiLvCType == isBeforeTwo) {
        return redcolor;
    }
    return redcolor;
}

- (NSString *)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index {
    
    if (self.PeiLvCType == isBeforeTwo) {
        
        return [NSString stringWithFormat:@"%@",self.titleArr[index]];;
    }else{
        
        return [NSString stringWithFormat:@"%@",self.jiaoqiutitleArr[index]];
    }
    return @"";
}

- (UIView *)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index {
    
    if (self.PeiLvCType == isBeforeTwo) {
        
        ZBPeiLvDetailTableVC  *peilvTableVC = [ZBPeiLvDetailTableVC new];
        peilvTableVC.model = self.model;
        peilvTableVC.PeiLvCDetailType = isDetailBeforeTwo;
        dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //2.添加任务到队列中，就可以执行任务
            //异步函数：具备开启新线程的能力
            dispatch_async(queue, ^{
                
                if (index==0) {
                    peilvTableVC.isHalfType = isHalfQuanChang;
                    peilvTableVC.oddsType = oddsTypeRangQiu;
                }
                });
            dispatch_async(queue, ^{
                
                if (index==1) {
                    peilvTableVC.isHalfType = isHalfBanChange;
                    peilvTableVC.oddsType = oddsTypeRangQiu;
                }
            });
            dispatch_async(queue, ^{
                if (index==2) {
                    peilvTableVC.isHalfType = isHalfQuanChang;
                    peilvTableVC.oddsType = oddsTypeDaXiao;
                }
                });
            dispatch_async(queue, ^{
                if (index==3) {
                    peilvTableVC.isHalfType = isHalfBanChange;
                    peilvTableVC.oddsType = oddsTypeDaXiao;
                }
                });
//        switch (index) {
//            case 0:
//            {
//                peilvTableVC.isHalfType = isHalfQuanChang;
//                peilvTableVC.oddsType = oddsTypeRangQiu;
//            }
//                break;
//            case 1:
//            {
//                peilvTableVC.isHalfType = isHalfBanChange;
//                peilvTableVC.oddsType = oddsTypeRangQiu;
//            }
//                break;
//            case 2:
//            {
//                peilvTableVC.isHalfType = isHalfQuanChang;
//                peilvTableVC.oddsType = oddsTypeDaXiao;
//            }
//                break;
//            case 3:
//            {
//                peilvTableVC.isHalfType = isHalfBanChange;
//                peilvTableVC.oddsType = oddsTypeDaXiao;
//            }
//                break;
//            default:
//                break;
//        }
        
        [self addChildViewController:peilvTableVC];
        
        return peilvTableVC.view;
    
    }else{
    
        ZBPeiLvDetailTableVC  *peilvTableVC = [ZBPeiLvDetailTableVC new];
        peilvTableVC.model = self.model;
        peilvTableVC.PeiLvCDetailType = isDetailAfterTwo;
        switch (index) {
            case 0:
            {
                peilvTableVC.jiaoQiuType = isJiaoQiuRangFen;
            }
                break;
            case 1:
            {
                peilvTableVC.jiaoQiuType = isJiaoQiuDaXiao;
            }
                break;
     
            default:
                break;
        }
        
        [self addChildViewController:peilvTableVC];
        
        return peilvTableVC.view;

    }
    
    return [UIView new];
}

#pragma mark - HSTabBarContentViewDelegate -
- (UIView *)highlightViewForTabBarItemInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView {
    
    UIView *view = [UIView new];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor redColor];
    [view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view);
        make.trailing.mas_equalTo(view).offset(-5);
        make.leading.mas_equalTo(view).offset(5);
        make.height.mas_equalTo(2);
    }];
    
    return view;
}

- (void)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"    dianji -%ld",index);
    if (index == 0) {
        return;
    }
}


@end
