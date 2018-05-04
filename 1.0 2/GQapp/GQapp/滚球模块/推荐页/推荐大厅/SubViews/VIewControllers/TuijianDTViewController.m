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

@property (nonatomic, strong) UIButton *btnFabu;
@property (nonatomic, strong) UIButton *btnFabuJingcai;

 @end

@implementation TuijianDTViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;


    if (![Methods login]) {
        
        _btnFabu.hidden = YES;
        _btnFabuJingcai.hidden = YES;
    }else{
        _btnFabu.hidden = NO;
       // _btnFabuJingcai.hidden = NO;
        _btnFabuJingcai.hidden = YES;

    }
    
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"推荐";
//    [self.view addSubview:self.search];
    [self setNavView];
    [self.view addSubview:self.tableViewV];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"tuijianDTShowProfit"];

    //推荐按钮
    _btnFabu = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnFabu setBackgroundImage:[UIImage imageNamed:@"fabunewtuijian"] forState:UIControlStateNormal];
    [_btnFabu setBackgroundImage:[UIImage imageNamed:@"fabunewtuijian"] forState:UIControlStateSelected];

    [_btnFabu addTarget:self action:@selector(btnFabuCilick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnFabu];
    
    [_btnFabu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15 - APPDELEGATE.customTabbar.height_myTabBar);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];

   
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

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"推荐大厅";
//    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateNormal];
//    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateHighlighted];
    
    
    nav.labTitle.hidden = YES;
    
    
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(10, 0, Width - 60, 28);
    btnSearch.center =CGPointMake(btnSearch.center.x, nav.labTitle.center.y);
    btnSearch.backgroundColor = [UIColor whiteColor];
    btnSearch.layer.cornerRadius = 4;
    btnSearch.layer.masksToBounds = YES;
    [btnSearch addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnSearch.height, btnSearch.height)];
//    imageV.center =
    imageV.image = [UIImage imageNamed:@"tuijianSearch"];
    [btnSearch addSubview:imageV];
    
    UILabel *labL = [[UILabel alloc] initWithFrame:CGRectMake(btnSearch.height, 0, 200, btnSearch.height)];
    labL.textColor = color99;
    labL.font = font14;
    labL.text = @"搜索专家";
    [btnSearch addSubview:labL];
    
    [nav addSubview:btnSearch];
    
    
    [self.view addSubview:nav];
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
- (void)btnFabuJinngcaiCilick:(UIButton *)btn
{
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    
     
    
    
    
}
- (void)btnFabuCilick:(UIButton *)btn
{
    
    // 测试代码
//    PeiLvDetailVC *peilvDDT = [PeiLvDetailVC new];
//    peilvDDT.hidesBottomBarWhenPushed = YES;
//    [APPDELEGATE.customTabbar pushToViewController:peilvDDT animated:YES];

//    JiShiPeiLvVC *jiShiPeiLvVC = [JiShiPeiLvVC new];
//    jiShiPeiLvVC.hidesBottomBarWhenPushed = YES;
//    [APPDELEGATE.customTabbar pushToViewController:jiShiPeiLvVC animated:YES];
////
//    DoubleBattleVC *battleVC = [DoubleBattleVC new];
//    battleVC.hidesBottomBarWhenPushed = YES;
//    [APPDELEGATE.customTabbar pushToViewController:battleVC animated:YES];

//    if (_btnFabu.selected == YES) {
//        return;
//    }
//    
//    _btnFabu.selected = YES;
    
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    
    [self toapplyAnalasis];
    
}

// 申请分析师
- (void)toapplyAnalasis
{
    
    
    
    FabuTuijianSelectedItemVC *jinCai = [[FabuTuijianSelectedItemVC alloc] init];
    jinCai.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:jinCai animated:YES];
    
    
  

}
- (void)search:(UIButton*)btn
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:searchVC animated:YES];

}

- (TuijianDatingTable *)tableViewV
{
    if (!_tableViewV) {
        _tableViewV = [[TuijianDatingTable alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar , Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - APPDELEGATE.customTabbar.height_myTabBar) style:UITableViewStylePlain];
    }
    return _tableViewV;
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
