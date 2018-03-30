//
//  BasicViewController.m
//  Wq
//
//  Created by WQ_h on 15/9/17.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BasicViewController

//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{
    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //没有色差
    self.navigationController.navigationBar.translucent = NO;
    //导航栏上的字体颜色
////    self.navigationController.navigationBar.tintColor = navTextColor;
//    //导航栏上的背景颜色
//    self.navigationController.navigationBar.barTintColor   = redcolor;
    
    //    导航栏title字体颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navTextColor,NSForegroundColorAttributeName, font18,NSFontAttributeName,nil]];
    
    
    
    //设置之后，当隐藏导航栏的时候状态栏不会占用高度，否则状态栏会占用20的高度
    // 不要用 self.topLayoutGuide.length  这个高度来设置view 的 Y值，否则会把状态栏的高度调出来，下面的这两个设置就没用了
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    
    //    去掉导航栏下面那条黑线，有的页面需要用到
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

//需要在自定义的nav 里面写一个方法
-(UIStatusBarStyle)preferredStatusBarStyle

{
    //info.plist 文件里面改变的是一进app的luanch页面的状态栏的颜色，这里改变的是viewcontroller的状态栏的颜色
    //info.plist 文件中的View controller-based status bar appearance  要设置为Yes
    return UIStatusBarStyleDefault;
    
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
