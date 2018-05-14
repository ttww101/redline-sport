//
//  DCTabBarController.m
//  DC_tabbar
//
//  Created by WQ_h on 15/12/21.
//  Copyright (c) 2015年 DC_H. All rights reserved.
//

#import "DCTabBarController.h"
#import "FirstViewController.h"
#import "BifenViewController.h"
#import "TuijianDTViewController.h"
//#import "QingbaoFPViewController.h"
#import "NewQingBaoViewController.h"

#import "MineViewController.h"
#import "UITabBar+badge.h"
#import "DCNavViewController.h"
#import "BaseWebViewController.h"

#import "TuijianDetailVC.h"
#import "ToolWebViewController.h"


NSString *const GQTableBarControllerName = @"GQTableBarControllerName";

NSString *const GQTabBarItemTitle = @"GQTabBarItemTitle";

NSString *const GQTabBarItemImage = @"GQTabBarItemImage";

NSString *const GQTabBarItemSelectedImage = @"GQTabBarItemSelectedImage";

NSString *const GQTabBarItemLoadH5 = @"GQTabBarItemLoadH5";

NSString *const GQTabBarItemWbebModel = @"GQTabBarItemWbebModel";



@interface DCTabBarController ()<UIGestureRecognizerDelegate>
{
    DCNavViewController *_firstNav;
    DCNavViewController *_secondNav;
    DCNavViewController *_thirdNav;
    DCNavViewController *_forthNav;
    DCNavViewController *_mineNav;
}

@property (strong, nonatomic)NSTimer *refreshUnreadCountTimer;

@property (nonatomic, copy) NSArray *tableBarItemArray;

//是否正在请求跳转分析页的接口
@property (nonatomic, assign) BOOL isToFenxi;


@end

@implementation DCTabBarController

- (instancetype)initWithItemArray:(NSArray *)itemArray {
    if (self) {
        _tableBarItemArray = [itemArray copy];
    }
    return self;
}

- (void)viewDidLoad {
     [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openOrCloseRefreshUnreadCountTimer:) name:NotificationOpenMainTableBarTimer object:nil];
    
    //推送跳转新闻页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToNewsWeb:) name:NotificationpushToNewsWeb object:nil];
    

    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height - %f", rectStatus.size.height);   // 高度
    
    // 导航栏（navigationbar）
    
    UINavigationController *nav = [[UINavigationController alloc] init];
    CGRect rectNav = nav.navigationBar.frame;
//    NSLog(@"nav width - %f", rectNav.size.width); // 宽度
//    NSLog(@"nav height - %f", rectNav.size.height);   // 高度
    
    self.height_myStateBar = rectStatus.size.height;
    self.height_myNavigationBar = rectStatus.size.height + rectNav.size.height;
    self.height_myTabBar = self.tabBar.frame.size.height;

    [self setupTabbarItems];
    [self setupTabBarStyle];
    if ([Methods login]) {
        [self creatRefreshUnreadCountTimer];
    }
    
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)updateUnreadCount:(NSNotification *)notification
{
    NSNumber *unreadNumber = [notification.userInfo objectForKey:@"unreadCount"];
    //角标
    _forthNav.tabBarItem.badgeValue = unreadNumber.integerValue>Zero? unreadNumber.stringValue :nil;
}
- (void)openOrCloseRefreshUnreadCountTimer:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:@"timer"] isEqualToString:@"open"])
    {
        [self creatRefreshUnreadCountTimer];
    }else if ([[notification.userInfo objectForKey:@"timer"] isEqualToString:@"close"])
    {
        [self.refreshUnreadCountTimer invalidate];
        self.refreshUnreadCountTimer = nil;
        [self.tabBar hideBadgeOnItemIndex:4];
    }
}
- (void)creatRefreshUnreadCountTimer
{
    
    if (!self.refreshUnreadCountTimer) {
        self.refreshUnreadCountTimer = [NSTimer scheduledTimerWithTimeInterval:RefreshTokenAndUnreadCountTimer target:self selector:@selector(loadUreadNotificationNum) userInfo:nil repeats:YES];
    }
}

-  (void)loadUreadNotificationNum
{
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"refreshToken"]) {
//        [self requestRefreshToken];
//
//    }
    
    if ([Methods login]) {
        
//        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"] != 0) {
        
            // Token 过期
            if (([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"]) < ([[NSDate date] timeIntervalSince1970]*1000)) {
                
                NSLog(@"token 过期");
                [self requestRefreshToken];
            }
//        }
        
//        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"OutOfRefreshTokenTime"] != 0) {
//            
//            // refreshToken 过期
//            if (([[NSUserDefaults standardUserDefaults] doubleForKey:@"OutOfRefreshTokenTime"]) <= ([[NSDate date] timeIntervalSince1970]*1000)) {
//                
//                NSLog(@"RefreshToken 过期");
////                [self OutOfRefreshTokenTimeFunc];
//            }
//        }

    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@"1" forKey:@"flag"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSNumber *unreadNoticeCount = [responseOrignal objectForKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateUnreadLabNum object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:unreadNoticeCount,@"unreadNoticeCount", nil]];
            if ([unreadNoticeCount integerValue]>0) {
                [self.tabBar showBadgeOnItemIndex:4];

            }else{
                [self.tabBar hideBadgeOnItemIndex:4];
            }
        }else{
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
    
    }
    
}
- (void)loadUreadNotificationNumInMineView
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@"1" forKey:@"flag"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSNumber *unreadNoticeCount = [responseOrignal objectForKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateUnreadLabNum object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:unreadNoticeCount,@"unreadNoticeCount", nil]];
            if ([unreadNoticeCount integerValue]>0) {
                [self.tabBar showBadgeOnItemIndex:4];
                
            }else{
                [self.tabBar hideBadgeOnItemIndex:4];
            }
        }else{
            //            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        //        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
    
    

}
-  (void)requestRefreshToken
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    
    
    NSString *refreshToken = [Methods getTokenModel].refreshToken;
    if (!refreshToken) {
        refreshToken = @"";
    }
    
    [parameter setObject:refreshToken forKey:@"refreshToken"]; //refreshToken
    
    
    
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_refreshtoken] ArrayFile:nil Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
//            TokenModel *model = [TokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
        
            NSString *tokenStr = [[responseOrignal objectForKey:@"data"] objectForKey:@"token"];
            NSString *refreshTokenStr = [[responseOrignal objectForKey:@"data"] objectForKey:@"refreshToken"];
            TokenModel *tokenModel =  [Methods getTokenModel];
            tokenModel.token = tokenStr;
            tokenModel.refreshToken = refreshTokenStr;
            
            [Methods updateTokentModel:tokenModel];
            
            [[NSUserDefaults standardUserDefaults] setDouble:[[responseOrignal objectForKey:@"time"] doubleValue] forKey:@"refreshTokentime"];
            [[NSUserDefaults standardUserDefaults] setDouble:[[responseOrignal objectForKey:@"time"] doubleValue] + OutOfRefreshTokenTime forKey:@"OutOfRefreshTokenTime"];
            
        }else{
                       
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
    
    
    
}

#pragma mark - refreshToken 过期 -  
- (void)OutOfRefreshTokenTimeFunc {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"登陆过期" preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"重新登录"];
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

//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refreshToken"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refreshTokenTime"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OutOfRefreshTokenTime"];
//        [[NSUserDefaults standardUserDefaults] synchronize];

//        [Methods toLogin];
        
    }];
    
    [alertOne setValue:color33 forKey:@"_titleTextColor"];
//    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
//    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)setupTabbarItems
{
    
    self.tabBar.tintColor = redcolor;
    self.tabBar.barTintColor = [UIColor whiteColor];
    [_tableBarItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        BOOL loadH5 = [dic[GQTabBarItemLoadH5] integerValue];
        if (loadH5) {
            [self addChildWebControllerWithVcStr:dic[GQTableBarControllerName] imageName:dic[GQTabBarItemImage] selectedImage:dic[GQTabBarItemSelectedImage] title:dic[GQTabBarItemTitle] tag:idx webModel:dic[GQTabBarItemWbebModel]];
        } else {
            [self addChildControllerWithVcStr:dic[GQTableBarControllerName] imageName:dic[GQTabBarItemImage] selectedImage:dic[GQTabBarItemSelectedImage] title:dic[GQTabBarItemTitle] tag:idx];
        }
       
    }];
    
}

- (void)addChildControllerWithVcStr:(NSString *)vcStr
                          imageName:(UIImage *)defaultImage
                      selectedImage:(UIImage *)selectedImage
                              title:(NSString *)title
                                tag:(NSInteger)tag {
    UIEdgeInsets insets = UIEdgeInsetsMake(Zero, Zero, Zero, Zero);
    Class targetClass = NSClassFromString(vcStr);
    UIViewController *target = [[targetClass alloc]init];
    target.tabBarItem.title = title;
    target.tabBarItem.image = defaultImage;
    target.tabBarItem.selectedImage = selectedImage;
    DCNavViewController *nav = [[DCNavViewController alloc] initWithRootViewController:target];
    nav.interactivePopGestureRecognizer.delegate = self;
    nav.tabBarItem.imageInsets = insets;
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:redcolor} forState:UIControlStateSelected];
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBWithOX(0x646464)} forState:UIControlStateNormal];
    [self addChildViewController:nav];
}

- (void)addChildWebControllerWithVcStr:(NSString *)vcStr
                          imageName:(UIImage *)defaultImage
                      selectedImage:(UIImage *)selectedImage
                              title:(NSString *)title
                                tag:(NSInteger)tag
                              webModel:(WebModel *)model {
    UIEdgeInsets insets = UIEdgeInsetsMake(Zero, Zero, Zero, Zero);
    Class targetClass = NSClassFromString(vcStr);
    BaseWebViewController *target = [[targetClass alloc]init];
    target.tabBarItem.title = title;
    target.model = model;
    target.tabBarItem.image = defaultImage;
    target.tabBarItem.selectedImage = selectedImage;
    DCNavViewController *nav = [[DCNavViewController alloc] initWithRootViewController:target];
    nav.interactivePopGestureRecognizer.delegate = self;
    nav.tabBarItem.imageInsets = insets;
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:redcolor} forState:UIControlStateSelected];
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBWithOX(0x646464)} forState:UIControlStateNormal];
    [self addChildViewController:nav];
}


- (void)setupTabBarStyle
{
    self.delegate = self;
}

//主页面切换的动画效果
#pragma mark -- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if (self.selectedIndex == [self.viewControllers indexOfObject:viewController]) {
        
        switch (tabBarController.selectedIndex) {
            case 0:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetFirstTableViewContentOffsetZero object:nil];
            }
                break;
            case 1:
            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetSecondTableViewContentOffsetZero object:nil];
                
            }
                break;
            case 2:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetThirdTableViewContentOffsetZero object:nil];
            }
                break;
            case 3:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetForthTableViewContentOffsetZero object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetForth2TableViewContentOffsetZero object:nil];

            }
                break;
            case 4:
            {
                
            }
                break;
                
            default:
                break;
        }

        
        return NO;
    }
    
    CATransition *animation  = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.25];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    
}
- (void)pushToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation pushViewController:viewController animated:animated];
//        self.hidesBottomBarWhenPushed = NO;
    }
}
- (void)presentToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation presentViewController:viewController animated:animated completion:completion];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//通知跳转页面
- (void)pushToNewsWeb:(NSNotification *)nofication
{
    
    
    NSDictionary *pushInfo = nofication.userInfo;
     UIViewController *currentControl = [Methods help_getCurrentVC];
    
    if ([pushInfo objectForKey:@"catalog"]== nil) {
        
    }else{
        NSInteger eventID = [[pushInfo objectForKey:@"catalog"]integerValue];
        switch (eventID) {
            case 0://首页
            {
                self.tabBarController.selectedIndex = 0;
            }
                break;
            case 2://推荐
            {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:3 toItemIndex:0];
            }
                
                break;
            case 1://情报
            {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:2 toItemIndex:0];
            }
                break;
            case 3://新闻呢
                //跳转网页
            {
                WebDetailViewController *webDetailVC = [[WebDetailViewController alloc] init];
                webDetailVC.urlTitle = [pushInfo objectForKey:@"title"];
                webDetailVC.url = [pushInfo objectForKey:@"url"];
                webDetailVC.urlId = [pushInfo objectForKey:@"targetid"];
                webDetailVC.hidesBottomBarWhenPushed = YES;
                [currentControl.navigationController pushViewController:webDetailVC animated:YES];
            }
                
                break;
            case 4://直播
            {
                [ self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:4 toItemIndex:0];
            }
                
                break;
                
                
                
            case 5:
            {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"";
                webModel.webUrl = [NSString stringWithFormat:@"%@/appH5/message.html?index=0", APPDELEGATE.url_ip];
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                webModel.hideNavigationBar = YES;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 6: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"胜平负";
                webModel.webUrl = [NSString stringWithFormat:@"%@/appH5/spfmode.html", APPDELEGATE.url_ip];
                webModel.showBuyBtn = YES;
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 7: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"亚盘";
                webModel.webUrl = [NSString stringWithFormat:@"%@/appH5/yamode.html", APPDELEGATE.url_ip];;
                webModel.showBuyBtn = YES;
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 8: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"大小球";
                webModel.webUrl = [NSString stringWithFormat:@"%@/appH5/dxmode.html", APPDELEGATE.url_ip];
                webModel.showBuyBtn = YES;
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 12: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"胜平负";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/appH5/cpspfmode.html", APPDELEGATE.url_ip];
                webModel.showBuyBtn = YES;
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 13: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"亚盘";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/appH5/cpyamode.html", APPDELEGATE.url_ip];
                webModel.showBuyBtn = YES;
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
                
            case 14: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/appH5/message.html?index=2", APPDELEGATE.url_ip];
                webModel.hideNavigationBar = YES;
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 15: {
                WebModel *webModel = [[WebModel alloc]init];
                webModel.title = @"";
                webModel.hideNavigationBar = YES;
                webModel.webUrl =  [NSString stringWithFormat:@"%@/appH5/message.html?index=1", APPDELEGATE.url_ip];
                ToolWebViewController *control = [[ToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
                
            case 9: {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:2 toItemIndex:0];
            }
                break;
                
            case 10: {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:0 toItemIndex:0];
            }
                
                break;
                
            case 11: {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:1 toItemIndex:0];
            }
                break;
            default:
                break;
        }
    }
}

//loop 跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    //index 1 基本面 2 情报面 3 推荐
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                
                LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                //从首页跳转分析页的时候不用反转
                model.neutrality = NO;
                FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
                fenxiVC.model = model;
                
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;

                UIViewController *currentControl = [Methods help_getCurrentVC];
                [currentControl.navigationController pushViewController:fenxiVC animated:YES];
                
                
            }
            _isToFenxi = NO;
            
            
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
            
        }];

    }else{
        
        
    }
    
    
}


@end
