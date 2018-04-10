//
//  MineViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/1/20.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "MineViewController.h"
#import "NoticePageVC.h"
#import "UsersCell.h"
#import "SettingVC.h"
#import "FriendsVC.h"
#import "AnQuanCenterVC.h"
#import "ToAnalystsVC.h"
#import "UserTuijianVC.h"
#import "RealNameCerVC.h"
#import "TongjiVC.h"
#import "FeedbackVC.h"
#import "FeedbackNewVC.h"
#import "MyBuyTuijianVC.h"
#define cellMineViewControllerUserCell @"cellMineViewControllerUserCell"
#define cellMineViewController @"cellMineViewController"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UILabel *labUnreadNum;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, assign) BOOL showBtnRenzheng;
@property (nonatomic, strong) NSString *unreadNoticeCount;
@end

@implementation MineViewController


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    self.navigationController.navigationBar.translucent = NO;

    if ([Methods login]) {
        if (_labUnreadNum.text == nil || [_labUnreadNum.text isEqualToString:@"0"]) {
            _labUnreadNum.hidden = YES;
        }else{
            _labUnreadNum.hidden = NO;
        }
        _showBtnRenzheng = YES;
        _userModel = [Methods getUserModel];
        
        
        
        [self loadUserInfo];
        [APPDELEGATE.customTabbar loadUreadNotificationNumInMineView];
        [self.tableView reloadData];
        
    }else{
        _showBtnRenzheng = NO;

        _labUnreadNum.hidden = YES;
        [self.tableView reloadData];

    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    [self setNavBtn];
    [self setNavView];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUnreadLabNum:) name:NotificationupdateUnreadLabNum object:nil];
}


#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"我的页面";
    nav.labTitle.font = font16;
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    
    
//    UIButton *unreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    unreadBtn.frame = CGRectMake(Width - APPDELEGATE.customTabbar.height_myNavigationBar + APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"unread"] forState:UIControlStateNormal];
    
    if ([Methods login]) {
        _labUnreadNum = [[UILabel alloc] initWithFrame:CGRectMake(nav.btnRight.width - 6 - 15, 5, 15, 15)];
        _labUnreadNum.font = font11;
        _labUnreadNum.adjustsFontSizeToFitWidth = YES;
        _labUnreadNum.textAlignment = NSTextAlignmentCenter;
        _labUnreadNum.textColor = [UIColor redColor];
        _labUnreadNum.backgroundColor = [UIColor whiteColor];
        _labUnreadNum.layer.cornerRadius = 15/2;
        _labUnreadNum.layer.masksToBounds = YES;
        _labUnreadNum.text = _unreadNoticeCount;
        if ([_unreadNoticeCount integerValue] > 9) {
            _labUnreadNum.frame = CGRectMake(nav.btnRight.width - 26, 5, 20, 15);
        }else if([_unreadNoticeCount integerValue] > 99){
            _labUnreadNum.frame = CGRectMake(nav.btnRight.width - 31, 5, 25, 15);
        }
        //                _labUnreadNum.text = @"99";
        _labUnreadNum.layer.borderColor = [UIColor whiteColor].CGColor;
        _labUnreadNum.layer.borderWidth = 1.0;
        if (_labUnreadNum.text == nil || [_labUnreadNum.text isEqualToString:@"0"]) {
            _labUnreadNum.hidden = YES;
        }else{
            _labUnreadNum.hidden = NO;
        }
        
        [nav.btnRight addSubview:_labUnreadNum];
        
    }
    
    [nav.btnRight addTarget:self action:@selector(rightBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:nav];
    
    
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        
    }else if(index == 2){
        //right
        
    }
}


- (void)updateUnreadLabNum:(NSNotification *)notification
{
    if ([Methods login]) {
        if ([[notification.userInfo objectForKey:@"unreadNoticeCount"] integerValue]>0) {
            _labUnreadNum.hidden = NO;
            _unreadNoticeCount = [NSString stringWithFormat:@"%@", [notification.userInfo objectForKey:@"unreadNoticeCount"] ];
            _labUnreadNum.text = _unreadNoticeCount;
        }else{
            _labUnreadNum.hidden = YES;
        }

    }else{
    
        _labUnreadNum.hidden = YES;

    }
    
}
- (void)setNavBtn
{
    
    if (_showBack) {
        UIImage *imageleft = [UIImage imageNamed:@"back"];
        UIImage *image = [imageleft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItem)];

    }
}
- (void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItem
{
    if ([Methods login]) {
        
               
        NoticePageVC *noticeVC = [[NoticePageVC alloc] init];
        noticeVC.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:noticeVC animated:YES];
    }else{
        [Methods toLogin];
    }

}


#pragma mark -- UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 45) style:UITableViewStyleGrouped]; //0, 0, Width, Height
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellMineViewController];
        [_tableView registerClass:[UsersCell class] forCellReuseIdentifier:cellMineViewControllerUserCell];
        _tableView.backgroundColor = colorE3;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        
//        [self setupTableViewMJHeader];
    }
    return _tableView;
}

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
        if ([Methods login]) {
            [self loadUserInfo];

        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {

 
    }else if (section == 1){
    
        
    } else{
        
        return [UIView new];
    }

    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
        {
            
            return 0.001;
        }
            break;
        case 1:
        {
            if (![Methods login]) {
                
                return 0.001;
            }
            return 0.001;
        }
            break;
        case 2:
        {
            return 10;
        }
            break;
        case 3:
        {
            return 10;
        }
            break;
            
        default:
            break;
    }
    /*
    if (section == 0) {
        return 0.0001;
    }else if (section == 1) {
        if (![Methods login]) {
            return 0;
        }
//        if (_userModel.analyst != 1) {
//            return 0;
//            
//        }
//
//        return 90;
        return 0;
    }else{
    
        return 10;
    }
     */
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
//        if (![Methods login]) {
//            return [UIView new];
//        }
        if (_userModel.autonym == 0) {
            if (_showBtnRenzheng) {
                UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
                footer.backgroundColor = colorFFFFDF;
                
                UILabel *title = [[UILabel alloc] init];
                title.font = font14;
                title.textColor = colorFF9900;
                title.text = @"为了您的账户安全，请立即 ";
                [footer addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(footer.mas_left).offset(15);
                    make.centerY.equalTo(footer.mas_centerY);
                }];
                
                
                UIButton *title1 = [ UIButton buttonWithType:UIButtonTypeCustom];
                title1.titleLabel.font = font14;
                title1.titleLabel.textColor = colorFF9900;
                [title1 setTitleColor:colorFF9900 forState:UIControlStateNormal];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"实名认证"];
                NSRange strRange = {0,[str length]};
                [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
                [title1 setAttributedTitle:str forState:UIControlStateNormal];
                [title1 addTarget:self action:@selector(renzheng) forControlEvents:UIControlEventTouchUpInside];
                [footer addSubview:title1];
                [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(title.mas_right).offset(5);
                    make.centerY.equalTo(footer.mas_centerY);
                }];
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(footer.width - 30, 0, 30, 30);
                [btn setBackgroundImage:[UIImage imageNamed:@"XX"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(cancelRenzhen:) forControlEvents:UIControlEventTouchUpInside];
                [footer addSubview:btn];
                return footer;
                
            }else{
                return [UIView new];
                
            }
            
        }
        else{
            
            
            return [UIView new];
            
        }
        
        
    }else{
        
        return [UIView new];
    }
    
}
- (void)btnMoneyClick
{
    
    NSString *strTitle = @"提款申请请联系官方客服";
    NSString *str_content = @"QQ:2811132884\n工作日：周一至周五 10：00-18：00";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strTitle message:str_content preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertTwo];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    
//    WKWebViewController *webVC = [[WKWebViewController alloc] init];
//    webVC.strurl = @"http://www.gunqiu.com/help/tikuan.html";
//    webVC.strtitle = @"账户提款";
//    webVC.hidesBottomBarWhenPushed = YES;
//    [APPDELEGATE.customTabbar pushToViewController:webVC animated:YES];
    

    
}
- (void)renzheng
{
    RealNameCerVC *real = [[RealNameCerVC alloc] init];
    
    real.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:real animated:YES];
    
    
}
- (void)cancelRenzhen:(UIButton *)btn
{
    _showBtnRenzheng = NO;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        if (_userModel.autonym == 0) {
            if (_showBtnRenzheng) {
                return 30;
            }
        }
        
        return 10;
    }else{
        
        return 0.0000001;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
//        case 2:
//            return 2;
//            break;
        case 2:
            return 2; //3
            break;
        case 3:
            return 2; //1 //2
            break;

        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
//            if ([Methods login]) {
                return [tableView fd_heightForCellWithIdentifier:cellMineViewControllerUserCell configuration:^(UsersCell* cell) {
                    cell.model = _userModel;
                }];
//            }else{
//                return 44;
//
//            }
        }
            break;
        case 1:
        {
            if (![Methods login]) {
                return 0;
            }
            return 44;
        }
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 44;
            break;
//        case 2:
//            return 44;
//            break;
            
        default:
            break;
    }

    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        

            UsersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMineViewControllerUserCell];
            if (!cell) {
                cell = [[UsersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMineViewControllerUserCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _userModel;
        
        /*
            UIButton *unreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            unreadBtn.frame = CGRectMake(Width - APPDELEGATE.customTabbar.height_myNavigationBar + APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
            [unreadBtn setBackgroundImage:[UIImage imageNamed:@"unread"] forState:UIControlStateNormal];
            
            if ([Methods login]) {
                _labUnreadNum = [[UILabel alloc] initWithFrame:CGRectMake(unreadBtn.width - 6 - 15, 5, 15, 15)];
                _labUnreadNum.font = font11;
                _labUnreadNum.adjustsFontSizeToFitWidth = YES;
                _labUnreadNum.textAlignment = NSTextAlignmentCenter;
                _labUnreadNum.textColor = redcolor;
                _labUnreadNum.backgroundColor = [UIColor whiteColor];
                _labUnreadNum.layer.cornerRadius = 15/2;
                _labUnreadNum.layer.masksToBounds = YES;
                _labUnreadNum.text = _unreadNoticeCount;
                if ([_unreadNoticeCount integerValue] > 9) {
                    _labUnreadNum.frame = CGRectMake(unreadBtn.width - 26, 5, 20, 15);
                }else if([_unreadNoticeCount integerValue] > 99){
                    _labUnreadNum.frame = CGRectMake(unreadBtn.width - 31, 5, 25, 15);
                }
//                _labUnreadNum.text = @"99";
                _labUnreadNum.layer.borderColor = redcolor.CGColor;
                _labUnreadNum.layer.borderWidth = 1.0;
                if (_labUnreadNum.text == nil || [_labUnreadNum.text isEqualToString:@"0"]) {
                    _labUnreadNum.hidden = YES;
                }else{
                    _labUnreadNum.hidden = NO;
                }
                
                [unreadBtn addSubview:_labUnreadNum];

            }
        
            [unreadBtn addTarget:self action:@selector(rightBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:unreadBtn];
         */
            //没有写delegate，跳转的时候直接在cell里面写跳转即可
            return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMineViewController];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMineViewController];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            while ([cell.contentView.subviews lastObject]!= nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }

        cell.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [cell.contentView addSubview:imageLeft];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, Width - 44, 44)];
        lab.textColor = color33;
        lab.font = font14;
        [cell.contentView addSubview:lab];
        
        UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
        imageMore.center = CGPointMake(imageMore.center.x, lab.center.y);
        imageMore.image = [UIImage imageNamed:@"meRight"];
        [cell.contentView addSubview:imageMore];
        
        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width , 0.5)]; //45   - 44
        viewline.backgroundColor = colorCellLine;
        [cell.contentView addSubview:viewline];

        switch (indexPath.section) {
            case 1:
            {
                if (![Methods login]) {
                    
                    lab.text = @"";
                    imageLeft.image = [UIImage imageNamed:@""];
                    imageMore.image = [UIImage imageNamed:@""];
                    viewline.backgroundColor = [UIColor clearColor];
                    /*
                    switch (indexPath.row) {
                        case 0:
                        {
                            lab.text = @"";
                            imageLeft.image = [UIImage imageNamed:@""];
                            imageMore.image = [UIImage imageNamed:@""];
                        }
                            break;
                        case 1:
                        {
                            lab.text = @"";
                            imageLeft.image = [UIImage imageNamed:@""];
                            
                        }
                            break;
                            
                        case 2:
                        {
                            lab.text = @"";
                            imageLeft.image = [UIImage imageNamed:@""];
                            
                            
                        }
                            break;
                        case 3:
                        {
                            lab.text = @"";
                            imageLeft.image = [UIImage imageNamed:@""];
                            viewline.backgroundColor = [UIColor clearColor];
                        }
                            break;
                            
                            
                        default:
                            break;
                    }
                     */
                }else{
                
                    switch (indexPath.row) {
                        case 0:
                        {
                            lab.text = @"推荐记录";
                            imageLeft.image = [UIImage imageNamed:@"tuijianuser1"];
                            
                        }
                            break;
                        case 1:
                        {
                            lab.text = @"推荐统计";
                            imageLeft.image = [UIImage imageNamed:@"tongjiuser1"];
                        }
                            break;
                            
                        case 2:
                        {
                            lab.text = @"购买明细";
                            imageLeft.image = [UIImage imageNamed:@"myBuyUser1"];
                            
                            
                        }
                            break;
                            
                            
                            
                        default:
                            break;
                    }
                }
            }
                break;
            /*
            case 2:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        lab.text = @"关注";
                        imageLeft.image = [UIImage imageNamed:@"guanzhuuser"];
                    }
                        break;
                    case 1:
                    {
                        lab.text = @"粉丝";
                        imageLeft.image = [UIImage imageNamed:@"fensiuser"];
                        viewline.backgroundColor = [UIColor clearColor];

                    }
                        break;
                    default:
                        break;
                }
            }
                break;
                */
            case 2:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        lab.text = @"申请分析师";
                        imageLeft.image = [UIImage imageNamed:@"myBuyUser1"];
//                        viewline.backgroundColor = [UIColor clearColor];
                    }
                        break;
                    case 1:
                    {
                        lab.text = @"安全中心";
                        imageLeft.image = [UIImage imageNamed:@"accountUser1"];
                        
                        
                    }
                        break;
                        
                    

                        

                    default:
                        break;
                }
            }
                break;
 
            case 3:
            {
                switch (indexPath.row) {
//                    case 0:
//                    {
//                        lab.text = @"邀请好友";
//                        imageLeft.image = [UIImage imageNamed:@"yaoqinghaoyou"];
////                        viewline.backgroundColor = [UIColor clearColor];
//                        
//                    }
//                        break;
                    case 0: //1
                    {
                        lab.text = @"意见反馈";
                        imageLeft.image = [UIImage imageNamed:@"suggestionUser1"];
//                        viewline.backgroundColor = [UIColor clearColor];
                        
                    }
                        break;
                    case 1: //2
                    {
                        lab.text = @"更多设置";
                        imageLeft.image = [UIImage imageNamed:@"moreUser1"];
                        viewline.backgroundColor = [UIColor clearColor];

                    }
                        break;
                    default:
                        break;
                }
            }
                break;
                
                
            default:
                break;
        }

        
        return cell;

    }
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.section == 1 && indexPath.row ==2 && ![Methods login] ) {
//        [Methods toLogin];
//        return;
//    }
//    
    switch (indexPath.section) {
        case 0:
        {
            //用户头像 登陆
            if(![Methods login]) {
                
                [Methods toLogin];
                return;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if(![Methods login]) {
                        
                        [Methods toLogin];
                        return;
                    }else{
                       
                        //                    推荐
                        UserTuijianVC *tuijian = [[UserTuijianVC alloc] init];
                        tuijian.userName = _userModel.nickname;
                        tuijian.userId = _userModel.idId;
                        tuijian.hidesBottomBarWhenPushed = YES;
                        [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    if(![Methods login]) {
                        
                        [Methods toLogin];
                        return;
                    }
                    UserViewController *userVC = [[UserViewController alloc] init];
                    userVC.userId = _userModel.idId;
                    userVC.hidesBottomBarWhenPushed = YES;
                    userVC.Number=1;
                    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
                    
                    
//                    统计

//                    TongjiVC *tongji = [[TongjiVC alloc] init];
//                    tongji.userModel = _userModel;
//                    tongji.hidesBottomBarWhenPushed = YES;
//                    [APPDELEGATE.customTabbar pushToViewController:tongji animated:YES];

                }
                    break;
                case 2:
                {
    
                    
                    if(![Methods login]) {
                        
                        [Methods toLogin];
                        return;
                    }
                    
                    MyBuyTuijianVC *myBuy = [[MyBuyTuijianVC alloc] init];
                    myBuy.userId = _userModel.idId;
                    myBuy.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:myBuy animated:YES];
                     
                }
                    break;
                case 3:
                {
                    /*
                    TongjiVC *tongji = [[TongjiVC alloc] init];
                    tongji.tongjiType = 1;
                    tongji.userModel = _userModel;
                    tongji.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:tongji animated:YES];
                     */
                    if(![Methods login]) {
                        
                        [Methods toLogin];
                        return;
                    }
                    UserViewController *userVC = [[UserViewController alloc] init];
                    userVC.userId = _userModel.idId;
                    userVC.hidesBottomBarWhenPushed = YES;
                    userVC.Number=3;
                    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];

                }
                    break;

                default:
                    break;
            }
        }
            break;
        /*
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
//                    关注
                    FriendsVC *friend = [[FriendsVC alloc] init];
                    friend.userId = _userModel.idId;
                    friend.selectedIndex = 0;
                    friend.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
                }
                    break;
                case 1:
                {
//                    粉丝
                    FriendsVC *friend = [[FriendsVC alloc] init];
                    friend.userId = _userModel.idId;
                    friend.selectedIndex = 1;
                    friend.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];

                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
         */
        case 2:
        {
            switch (indexPath.row) {
                    
                case 0:
                {
                    if(![Methods login]) {
                        
                        [Methods toLogin];
                        return;
                    }
                    [[DependetNetMethods sharedInstance] loadUserInfocompletion:^(UserModel *userback) {
                        UserModel *model = [Methods getUserModel];
                        ToAnalystsVC *analysts = [[ToAnalystsVC alloc] init];
                        analysts.hidesBottomBarWhenPushed = YES;
                        analysts.type = model.analyst;
                        analysts.model = model;
                        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                        

                    } errorMessage:^(NSString *msg) {
                        UserModel *model = [Methods getUserModel];
                        ToAnalystsVC *analysts = [[ToAnalystsVC alloc] init];
                        analysts.hidesBottomBarWhenPushed = YES;
                        analysts.type = model.analyst;
                        analysts.model = model;
                        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                        

                    }];
                    
                    
   
                    
//                    申请分析师

                }
                    break;
                case 1:
                {
//                    安全中心
                    if(![Methods login]) {
                        
                        [Methods toLogin];
                        return;
                    }
                    UserModel *model = [Methods getUserModel];
                    AnQuanCenterVC *anquanVc = [[AnQuanCenterVC alloc] init];
                    anquanVc.hidesBottomBarWhenPushed = YES;
                    anquanVc.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:anquanVc animated:YES];
                }
                    break;
            

                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
//                case 0:
//                    
//                {
//                    //                邀请好友
//                    
//                }
//                    break;
                case 0: //1
                    
                {
                    //                反馈
                    FeedbackVC *feed = [[FeedbackVC alloc] init];
                    feed.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:feed animated:YES];
//                    FeedbackNewVC *feed = [[FeedbackNewVC alloc] init];
//                    feed.hidesBottomBarWhenPushed = YES;
//                    [APPDELEGATE.customTabbar pushToViewController:feed animated:YES];

                }
                    break;
                case 1: //2
                {
//                    更所选项
                    SettingVC *setVC = [[SettingVC alloc] init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:setVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;

        default:
            break;
    }
}


- (void)loadUserInfo
{
    

    
    _userModel = [Methods getUserModel];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userModel.idId] forKey:@"id"];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_userinfo] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
//        [APPDELEGATE.customTabbar loadUreadNotificationNum];

    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            _userModel = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            
            [Methods updateUsetModel:_userModel];

            [self.tableView reloadData];
        }else{
        }

        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {

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
