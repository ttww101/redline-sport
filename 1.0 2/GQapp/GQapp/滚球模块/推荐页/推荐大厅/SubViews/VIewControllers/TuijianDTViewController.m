//
//  TuijianDTViewController.m
//  GQapp
//
//  Created by WQ on 16/11/7.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "TuijianDTViewController.h"
#import "SearchViewController.h"
#import "BIfenSelectedSaishiModel.h"
#import "FabuTuijianSelectedItemVC.h"
#import "ToAnalystsVC.h"
#import "FaBuSucceedVCViewController.h"
#import "PeiLvDetailVC.h"
#import "JiShiPeiLvVC.h"
#import "DoubleBattleVC.h"

@interface TuijianDTViewController ()

 @end

@implementation TuijianDTViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:false animated:YES];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 22, 22);
    [btn addTarget:self action:@selector(publishRecommend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐大厅";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableViewV];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"tuijianDTShowProfit"];

    [self.tableViewV addSelectedView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSetConSize) name:@"tuijianSetSize" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContentOffsetZero) name:NotificationsetForthTableViewContentOffsetZero object:nil];
    

}
- (void)setTableViewContentOffsetZero
{
    [self.tableViewV setContentOffset:CGPointZero animated:YES];
}
- (void)setSetConSize{
    [self.tableViewV setContentOffset:CGPointMake(0, 0)];
}


- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        

        
    }else if(index == 2){
        
        
        
//        SelectedNewJingcaiListVC *jingcaiVC = [[SelectedNewJingcaiListVC alloc] init];
//        jingcaiVC.hidesBottomBarWhenPushed = YES;
//        [APPDELEGATE.customTabbar pushToViewController:jingcaiVC animated:YES];
//
        
        WebVC *webV = [[WebVC alloc] init];
        
        webV.strtitle = @"推荐市场规则";
        //webV.strurl =[NSString stringWithFormat:@"%@/help/v1.8.0/tuijian.html",APPDELEGATE.url_ServerWWW];
        webV.strurl=TUIJIAN_API_HTML;
        webV.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:webV animated:YES];

    }
}

- (TuijianDatingTable *)tableViewV {
    if (!_tableViewV) {
        _tableViewV = [[TuijianDatingTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableViewV;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Events

- (void)publishRecommend {
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    FabuTuijianSelectedItemVC *jinCai = [[FabuTuijianSelectedItemVC alloc] init];
    jinCai.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:jinCai animated:YES];
}

@end
