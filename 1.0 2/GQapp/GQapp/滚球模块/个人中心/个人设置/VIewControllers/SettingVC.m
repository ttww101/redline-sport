//
//  SettingVC.m
//  GQapp
//
//  Created by WQ on 2017/4/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "SettingVC.h"
#import "FeedbackVC.h"
#import "PushSettingVC.h"
#import "AnQuanCenterVC.h"
#import "ArchiveFile.h"
@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation SettingVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}


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
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self.view addSubview:self.tableView];

}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"更多设置";
    nav.labTitle.font = font14;
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
//        case 3:
//        {
//            return 1;
//        }
            break;

        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 2) {
//        return 30;
//    }
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    if (section == 2) {
//        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
//        footer.backgroundColor = colorTableViewBackgroundColor;
//        UILabel *labDetail = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width-40, 30)];
//        labDetail.numberOfLines = 2;
//        labDetail.font = font9;
//        labDetail.textColor = color66;
//        labDetail.text = @"要开启或者关闭滚球的推送通知,请在iphone的\"设置\"-\"通知\"中找到滚球进行设置";
//        [footer addSubview:labDetail];
//        return footer;
//        
//    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    switch (indexPath.section) {
//        case 0:
//        {
//            return 44;
//        }
//            break;
//        case 1:
//        {
//            if (![Methods login]) {
//                return 0;
//            }
//            return 44;
//        }
//            break;
//        case 2:
//        {
//            if (![Methods login]) {
//                return  106;
//            }
//            return 160;
//
//        }
//            break;
//        default:
//            break;
//    }
//    
   
    if (indexPath.section != 2) {
        
        return 44;

    }else{
        if (![Methods login]) {
            return  106;
        }
        return 160;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section != 3) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            while ([cell.contentView.subviews lastObject]!= nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 40, 44)];
        lab.textColor = color33;
        lab.font = font14;
        [cell.contentView addSubview:lab];
        
        UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
        imageMore.center = CGPointMake(imageMore.center.x, lab.center.y);
        imageMore.image = [UIImage imageNamed:@"meRight"];
        [cell.contentView addSubview:imageMore];
        
        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width , 0.5)]; //- 20
        viewline.backgroundColor = colorCellLine;
        [cell.contentView addSubview:viewline];
        
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
                   lab.text = @"账户与安全";
                }
                    break;
                case 1:
                {
                     lab.text = @"推送设置";

                }
                    break;
                    
                case 2: {
                    lab.text = @"清除缓存";
                    
                    UILabel *sizeLab = [[UILabel alloc] init]; //WithFrame:CGRectMake(Width - 15 - 7 - 7 - 40, 14.5, 40, 14)
                    sizeLab.text = [self getCashesSize];
                    sizeLab.font = font12;
                    sizeLab.textColor = color99;
                    [cell.contentView addSubview:sizeLab];
                    [sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(cell.contentView);
                        make.trailing.equalTo(imageMore.mas_leading).offset(-15);
                    }];
                }

                default:
                    break;
            }

        }else if (indexPath.section == 1){
            
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"用户服务协议";
                    
                }
                    break;
                case 1:
                {
                    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
                    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
                    
                    lab.text = [NSString stringWithFormat:@"关于滚球体育(%@)",currentVersion];
                    
//                    lab.attributedText = [Methods withContent:lab.text WithColorText:currentVersion textColor:color99 strFont:font13];
                    viewline.backgroundColor = [UIColor clearColor];
                    
                }
                    break;
                default:
                    break;
            }
        }else{
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            while ([cell.contentView.subviews lastObject]!= nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
            
            UIView *basiceV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 160)];
            basiceV.backgroundColor = colorTableViewBackgroundColor;
            [cell.contentView addSubview:basiceV];
            
            UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
            btnLogout.frame = CGRectMake(65, 90, Width - 130, 44);
            btnLogout.backgroundColor = redcolor;
            btnLogout.layer.cornerRadius = 3;
            btnLogout.layer.masksToBounds = YES;
            btnLogout.titleLabel.font = font16;
            [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
            [btnLogout addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
            [basiceV addSubview:btnLogout];
            
            if (![Methods login]) {
                btnLogout.frame = CGRectMake(15, 0, Width - 30, 0);
                
            }
            return cell;
//            imageMore.image = [UIImage imageNamed:@"clear"];
        }
        

        return cell;

//    }else{
        
       /*
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            while ([cell.contentView.subviews lastObject]!= nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        
        UIView *basiceV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 160)];
        basiceV.backgroundColor = colorTableViewBackgroundColor;
        [cell.contentView addSubview:basiceV];
        
        UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogout.frame = CGRectMake(15, 10, Width - 30, 44);
        btnLogout.backgroundColor = redcolor;
        btnLogout.layer.cornerRadius = 3;
        btnLogout.layer.masksToBounds = YES;
        btnLogout.titleLabel.font = font16;
        [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
        [btnLogout addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        [basiceV addSubview:btnLogout];
        
        if (![Methods login]) {
            btnLogout.frame = CGRectMake(15, 0, Width - 30, 0);

        }

        */
        
        
//        UILabel *labWX = [[UILabel alloc] init];
//        labWX.textColor = color33;
//        labWX.font = font12;
//        labWX.text = @"微信公众号：gunqiuwang";
//        [basiceV addSubview:labWX];
//        [labWX mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(btnLogout.mas_bottom).offset(15);
//            make.centerX.equalTo(btnLogout.mas_centerX);
//        }];
//        
//        UILabel *labQun = [[UILabel alloc] init];
//        labQun.textColor = color33;
//        labQun.font = font12;
//        [labQun setAttributedText:[Methods withContent:@"QQ交流群：198898776（验证：滚球体育）" contentColor:color33 WithColorText:@"（验证：滚球体育）" textColor:color99]];
//        [basiceV addSubview:labQun];
//        [labQun mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(labWX.mas_bottom).offset(5);
//            make.centerX.equalTo(btnLogout.mas_centerX);
//        }];
//        
//        UILabel *labVersion = [[UILabel alloc] init];
//        labVersion.textColor = color33;
//        labVersion.font = font13;
//        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//        NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
//        
////        labVersion.text = [NSString stringWithFormat:@"版本 %@",currentVersion];
//        labVersion.text = [NSString stringWithFormat:@"版本 %@dev (170911)",currentVersion];
//        [basiceV addSubview:labVersion];
//        [labVersion mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(labQun.mas_bottom);
//            make.centerX.equalTo(btnLogout.mas_centerX);
//            make.height.mas_equalTo (40);
//        }];
        
        
//        return cell;

    
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
               // 安全中心
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
            case 1:
            {
                if (![Methods login]) {
                    [Methods toLogin];
                    return;
                }
                
                PushSettingVC *pushSetVC = [[PushSettingVC alloc] init];
                pushSetVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:pushSetVC animated:YES];
            }
                break;
                
            case 2: {
                //                缓存
                [self putBuffer];
            }

            default:
                break;
        }
    }else if (indexPath.section == 1){
    
        switch (indexPath.row) {
            case 0:
            {
                // 用户服务协议
                
                WKWebViewController *webVC = [[WKWebViewController alloc] init];
                webVC.strurl = [NSString stringWithFormat:@"%@/help/agreement.html",APPDELEGATE.url_ServerAgreement];
                webVC.strtitle = @"用户服务协议";
                webVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:webVC animated:YES];

            }
                break;
                
                case 1:
            {
                //        关于
                
                WKWebViewController *webVC = [[WKWebViewController alloc] init];
                webVC.strurl = [NSString stringWithFormat:@"%@/notice/about.html",APPDELEGATE.url_ServerWWW];
                webVC.strtitle = @"关于滚球体育";
                webVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:webVC animated:YES];
                
            }
                break;
            default:
                break;
        }
        
    }
//    else{
//    
//    
//    }
}
- (void)loginOut
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"确定退出当前账号吗"];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"close",@"timer", nil]];
        [self.navigationController popViewControllerAnimated:YES];

        TokenModel *tokenModel = [Methods getTokenModel];
        tokenModel.token = @"";
        tokenModel.refreshToken = @"";
        [Methods updateTokentModel:tokenModel];
        [[NSUserDefaults standardUserDefaults] setDouble:[@"0" doubleValue] forKey:@"refreshTokentime"];
        [[NSUserDefaults standardUserDefaults] setDouble:[@"0" doubleValue] forKey:@"OutOfRefreshTokenTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [ArchiveFile clearCachesWithFilePath:TableConfig];
        
    }];
    
    [alertOne setValue:color33 forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    
//    //退出登录之后要把聊天室的信息也更细
//    [[RCIM sharedRCIM] disconnect];
//    [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenRongyunYouke"] success:^(NSString *userId) {
//        NSLog(@"%@",userId);
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"");
//        
//    } tokenIncorrect:^{
//        NSLog(@"");
//        
//    }];
//    [[RCIM sharedRCIM] clearUserInfoCache];
//    RCUserInfo *userInfo = [RCUserInfo new];
//    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSString *userId = [Methods md5WithString:idfv];
//    userInfo.name = @"游客";
//    userInfo.userId = userId;
//    userInfo.portraitUri = url_defaultUserPic;
//    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
//    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:@"游客" portrait:url_defaultUserPic];
    
}

/*
 （1）Documents：应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
 （2）tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
 （3）Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 */

//清除缓存按钮的点击事件
- (void)putBuffer
{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"决定清除所有缓存吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        [[SDImageCache sharedImageCache] clearDisk];

        [[SDImageCache sharedImageCache] clearMemory];
        [self.tableView reloadData];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self showDetailViewController:alert sender:nil];
}

- (NSString *)getCashesSize {

    //主要清楚sdwebimage的缓存，其他的可以忽略
    CGFloat size = [[SDImageCache sharedImageCache] getSize];
    
    NSString *message = @"";
    
    if (size > (1024 * 1024))
    {
        size = size / (1024 * 1024);
        message = [NSString stringWithFormat:@"%.1fM", size];
    }
    else if (size > 1024)
    {
        size = size / 1024;
        message = [NSString stringWithFormat:@"%.1fKB", size];
    }else{
        message = [NSString stringWithFormat:@"%.1fB", size];
    }

    return message;
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
