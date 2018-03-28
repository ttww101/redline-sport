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

    if (_btnFabu.selected == YES) {
        return;
    }
    
    _btnFabu.selected = YES;
    
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    
    [[DependetNetMethods sharedInstance] loadUserInfocompletion:^(UserModel *userback) {
        _btnFabu.selected = NO;
        [self toapplyAnalasis];
    } errorMessage:^(NSString *msg) {
        _btnFabu.selected = NO;

        [self toapplyAnalasis];

    }];
    
    
    
    
    
}

// 申请分析师
- (void)toapplyAnalasis
{
    UserModel *user = [Methods getUserModel];
//    user.analyst   = 3;

    if (user.analyst == 1) {
        
        if (user.reachLimit == YES) {
            
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"周一~周五每天不超过5个方案，周六~周日每天不超过10个方案"];
            return;
        }
        
        
        FabuTuijianSelectedItemVC *jinCai = [[FabuTuijianSelectedItemVC alloc] init];
        jinCai.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:jinCai animated:YES];
        return;
    }
//    user.analyst   = 1;
    NSString *strTitle = @"您尚未认证分析师";
    NSString *str_content = @"申请分析师";
    
//    if (user.analyst == 1) {
//        strTitle = @"您的分析师认证资料未完善，请完善后再发推荐";
//        str_content = @"立即完善";
//    }

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strTitle];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:str_content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ToAnalystsVC *analysts = [[ToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = user.analyst;
        
//                analysts.type = 1;
        
        
        analysts.model = user;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
        
    }];
    
    [alertOne setValue:redcolor forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

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
