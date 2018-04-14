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
@interface DCTabBarController ()<UIGestureRecognizerDelegate>
{
    DCNavViewController *_firstNav;
    DCNavViewController *_secondNav;
    DCNavViewController *_thirdNav;
    DCNavViewController *_forthNav;
    DCNavViewController *_mineNav;
}

@property (strong, nonatomic)NSTimer *refreshUnreadCountTimer;
@end

@implementation DCTabBarController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
//}
//
//-(void) viewDidAppear:(BOOL)animated
//{
//    [self.selectedViewController endAppearanceTransition];
//}
//
//-(void) viewWillDisappear:(BOOL)animated
//{
//    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
//}
//
//-(void) viewDidDisappear:(BOOL)animated
//{
//    [self.selectedViewController endAppearanceTransition];
//}

- (void)viewDidLoad {
     [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openOrCloseRefreshUnreadCountTimer:) name:NotificationOpenMainTableBarTimer object:nil];

    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height - %f", rectStatus.size.height);   // 高度
    
    // 导航栏（navigationbar）
    
    UINavigationController *nav = [[UINavigationController alloc] init];
    CGRect rectNav = nav.navigationBar.frame;
    NSLog(@"nav width - %f", rectNav.size.width); // 宽度
    NSLog(@"nav height - %f", rectNav.size.height);   // 高度
    
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
- (void)updateUnreadCount:(NSNotification *)notification
{
    NSNumber *unreadNumber = [notification.userInfo objectForKey:@"unreadCount"];
    //角标
    _forthNav.tabBarItem.badgeValue = unreadNumber.integerValue>Zero? unreadNumber.stringValue :nil;
}
- (void)openOrCloseRefreshUnreadCountTimer:(NSNotification *)notification
{
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
    
    [parameter setObject:[Methods getTokenModel].refreshToken forKey:@"refreshToken"]; //refreshToken
    
    
    
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
    UIEdgeInsets insets = UIEdgeInsetsMake(Zero, Zero, Zero, Zero);
    FirstViewController *FirstVC = [[FirstViewController alloc] init];
    _firstNav = [[DCNavViewController alloc] initWithRootViewController:FirstVC];
    _firstNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"shouye"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"shouye-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _firstNav.tabBarItem.imageInsets  = insets;
    _firstNav.interactivePopGestureRecognizer.delegate =self;
    BifenViewController *bifenVC = [[BifenViewController alloc] init];
    _secondNav = [[DCNavViewController alloc] initWithRootViewController:bifenVC];
    _secondNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"比分" image:[[UIImage imageNamed:@"bifen"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"bifen-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _secondNav.tabBarItem.imageInsets = insets;
    _secondNav.interactivePopGestureRecognizer.delegate = self;
    
    
//    ThirdViewController *ThirdVC = [[ThirdViewController alloc] init];
//    BaoliaoViewController *baoliaoVC = [[BaoliaoViewController alloc] init];
    
     NewQingBaoViewController *baoliaoVC = [[NewQingBaoViewController alloc] init];

//    baoliaoVC.typedVC = typedVCBaoliao;
    _thirdNav = [[DCNavViewController alloc] initWithRootViewController:baoliaoVC];
    _thirdNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"情报" image:[[UIImage imageNamed:@"qingbao"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"qingbao-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _thirdNav.tabBarItem.imageInsets = insets;
    _thirdNav.interactivePopGestureRecognizer.delegate = self;
//    ForthViewController *ForthVC = [[ForthViewController alloc] init];
    TuijianDTViewController *tuijianVC = [[TuijianDTViewController alloc] init];
    _forthNav = [[DCNavViewController alloc] initWithRootViewController:tuijianVC];
    _forthNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[[UIImage imageNamed:@"tuijian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tuijian-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    图片的偏移量
    _forthNav.tabBarItem.imageInsets = insets;
    _forthNav.interactivePopGestureRecognizer.delegate = self;
    //角标
//    _forthNav.tabBarItem.badgeValue = @"1";
    //单个设置title的默认和选中的颜色 优先级高
//    [_forthNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [_forthNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    //
    MineViewController *mineVC = [[MineViewController alloc] init];
    _mineNav = [[DCNavViewController alloc] initWithRootViewController:mineVC];
    _mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"wode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wode-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _mineNav.tabBarItem.imageInsets  = insets;
//    _mineNav.tabBarItem.badgeValue = @".";
    _mineNav.interactivePopGestureRecognizer.delegate = self;
    
    //选中时的title的颜色,全部设置,优先级低
    self.tabBar.tintColor = redcolor;
    //背景图片,像素为 x * 98 (名字@2x)  需要的像素是 49
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"white"];
    //选中的那个item的背景图片 根据机型的不同,需要的大小而不同,高都是 49 ,宽度要计算,准备多张,
    
//    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"8049"];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.viewControllers = [NSArray arrayWithObjects:_firstNav,_secondNav,_thirdNav,_forthNav,_mineNav,nil];
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















/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
