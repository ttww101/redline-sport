//
//  DCNavViewController.m
//  GQapp
//
//  Created by WQ on 2016/12/23.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "DCNavViewController.h"

@interface DCNavViewController ()<UIGestureRecognizerDelegate, UINavigationBarDelegate>

@end

@implementation DCNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  这句很核心 稍后讲解
    id target = self.interactivePopGestureRecognizer.delegate;
    //  这句很核心 稍后讲解
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
    
    [self configNavigation];
}


- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    BOOL shouldPop = YES;
    
    // 已修改（标记1）
    NSUInteger count = self.viewControllers.count;
    NSUInteger itemsCount = navigationBar.items.count;
    if(count < itemsCount){
        return shouldPop;
    }
    
    // 通过点击返回键和直接调用popViewController，得到的topViewController不同
    UIViewController *vc = self.topViewController;
    if([vc respondsToSelector:@selector(shouldPopOnBackButtonPress)]){
        shouldPop = [vc performSelector:@selector(shouldPopOnBackButtonPress)];
    }
    if(shouldPop == NO){
        // 返回NO后，返回按钮中的 < 会置灰（文字恢复为黑色）通过设置NavigationBarHidden属性使它恢复
        [self setNavigationBarHidden:YES];
        [self setNavigationBarHidden:NO];
    }else{
        // 不能直接调用pop,如果是通过popViewController调起,会造成循环调用此方法
        // 如果是通过调用[navigationController popViewControllerAnimated:]导致的shouldPop delegate被调用,
        // 此时已经完成了viewController的pop, viewControllers.count 会比 navigationBar.items.count小1
        // 这种情况就不必再次调用popViewController，否则会导致循环
        if(count >= itemsCount){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self popViewControllerAnimated: YES];
            });
        }
    }
    return shouldPop;
}

//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //解决与左滑手势冲突
    
    CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    return self.childViewControllers.count == 1 ? NO : YES;
}

//改变状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle

{
    UIViewController* topVC = self.topViewController;
    
    return [topVC preferredStatusBarStyle];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated. backNew
}

#pragma mark - Private Method

- (void)configNavigation {
    self.navigationBar.barTintColor = redcolor;
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *backImage = [[UIImage imageNamed:@"backNew"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:backImage forState:UIControlStateNormal];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(leftBtnItemAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - action

- (void)leftBtnItemAction {
    [self popViewControllerAnimated:YES];
}

/*
 在实现之前,先推测一下苹果实现pop的大概思路.首先,需要在一个合适的view上添加边缘手势,其次,针对这个手势必然要实现一个方法响应该事件.当然,根据苹果一贯代码风格,处理该事件很可能交给另一个专门的类去处理.
 
 假如以上推测成立,只要获得那个专门处理事件的类和方法,实现全屏pop效果就很简单了.
 
 下面是笔者在分析苹果实现pop的部分信息.看到这,是否若有所悟?
 
 (lldb) pclass [self interactivePopGestureRecognizer]
 // 信息->1
 UIScreenEdgePanGestureRecognizer
 | UIPanGestureRecognizer
 |    | UIGestureRecognizer
 |    |    | NSObject
 (lldb) pclass [self interactivePopGestureRecognizer].delegate
 // 信息->2
 _UINavigationInteractiveTransition
 | _UINavigationInteractiveTransitionBase
 |    | UIPercentDrivenInteractiveTransition
 |    |    | NSObject
 (lldb) po [self interactivePopGestureRecognizer]
 // 信息->3
 <UIScreenEdgePanGestureRecognizer: 0x7fab1243be00; state = Possible; enabled = NO; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fab126a4a60>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fab1243b850>)>>
 
 (lldb) po [self interactivePopGestureRecognizer].delegate
 // 信息->4
 <_UINavigationInteractiveTransition: 0x7fab1243b850>
 
 (lldb)
 从信息1中,可以知道interactivePopGestureRecognizer属性并不是UIGestureRecognizer类型的对象,而是其子类UIPanGestureRecognizer的子类UIScreenEdgePanGestureRecognizer类型的对象.
 
 UIScreenEdgePanGestureRecognizer是边缘触发手势,在系统中公有API,里面只有一个edges属性,用来设置具体边缘有效,如左边缘.具体可以参考官方API.
 
 在信息3中,可以看到
 
 target= (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fab1243b850>)
 这样一条信息,里面包含了target和action.看到这是不是很兴奋?iOS开发者再也属性不过的目标-动作模式了.
 
 到这里,已经可以确定苹果的实现方式是通过边缘触发手势处理pop的.这里target是私有的,如何获得呢?于是,网上很多人开始使用runtime来获得一些私有的方法.笔者一般不愿在正式上线的项目中使用runtime获得私有API,虽然不一定会被苹果拒接,但是会有一定风险,毕竟笔者最近人品还没爆发.
 
 有没不用运行时的好方法?
 
 先别着急,继续看信息2和4, interactivePopGestureRecognizer的代理是_UINavigationInteractiveTransition,看类名可以想到该类和交互转场相关.分析到这里,基本上可以推测出苹果是通过代理将事件处理委托给了_UINavigationInteractiveTransition对象.
 
 在信息3中,可以看到target=<_UINavigationInteractiveTransition 0x7fab1243b850>的地址是0x7fab1243b850,信息4中<_UINavigationInteractiveTransition: 0x7fab1243b850>的地址也是0x7fab1243b850.
 
 由以上分析,可以确定苹果的实现方式是将处理边缘触发的事件的任务委托给了_UINavigationInteractiveTransition,在_UINavigationInteractiveTransition中有处理该事件的方法handleNavigationTransition:.
 
 代码分析
 id target = self.interactivePopGestureRecognizer.delegate;
 这句代码目的是获取事件处理对象.以便自己添加的手势可以把事件处理委托给它.
 
 SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
 这句就是获取委托对象里的处理方法.
 
 UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
 fullScreenGes.delegate = self;
 [targetView addGestureRecognizer:fullScreenGes];
 这几句就是添加自己的全屏手势,通过目标-动作模式把任务交给了系统委托对象处理.
 
 建议
 如果需要自定制导航时,实现是写在UINavigationController子类中,比较方便.如果不需要,可以单独写一个分类.这里写在GLNavigationController中,其中GLNavigationController.h继承自UINavigationController.
 
 其他提示
 如果你的导航在不同控制器间有隐藏状态栏的话,隐藏方法需要使用带有animated:参数的方法setNavigationBarHidden: animated:,否则过渡会出问题.
 不用担心审核问题,是可以通过的.
 
  */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
