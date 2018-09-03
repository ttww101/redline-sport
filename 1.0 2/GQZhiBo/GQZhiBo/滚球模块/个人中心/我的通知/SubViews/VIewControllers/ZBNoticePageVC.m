//
//  ZBNoticePageVC.m
//  GQapp
//
//  Created by WQ on 16/10/10.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBNoticePageVC.h"
#import "ZBNoticeViewController.h"
#import "ZBRemindViewController.h"
@interface ZBNoticePageVC ()<ViewPagerDelegate,ViewPagerDataSource,NavViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UISegmentedControl *segmentEvent;
@end

@implementation ZBNoticePageVC
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
    
    self.delegate=self;
    self.dataSource = self;
    self.currentIndex = 0;
    [self reloadData];
    [self setNavView];
}


#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
    
    self.segmentEvent.center = CGPointMake(nav.labTitle.center.x, nav.labTitle.center.y);
    [nav addSubview:self.segmentEvent];
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

- (UISegmentedControl *)segmentEvent
{
    if (!_segmentEvent) {
        _segmentEvent = [[UISegmentedControl alloc] initWithItems:@[@"提醒",@"通知"]];
        _segmentEvent.frame = CGRectMake(0, 0, 100, 25);

        _segmentEvent.tintColor =[UIColor whiteColor] ;
        _segmentEvent.backgroundColor= redcolor;

        _segmentEvent.selectedSegmentIndex = 0;
        _segmentEvent.layer.cornerRadius = 3;
        _segmentEvent.layer.borderColor = [UIColor whiteColor].CGColor;
        _segmentEvent.layer.borderWidth = 1;
        [_segmentEvent addTarget:self action:@selector(segmentEventValueChanged:) forControlEvents:UIControlEventValueChanged];

    }
    return _segmentEvent;
}

- (void)segmentEventValueChanged:(UISegmentedControl *)segmentC
{
    
    UIPageViewControllerNavigationDirection direction;
    
    if (segmentC.selectedSegmentIndex < _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    UIViewController *viewController = [self viewControllerAtIndex:segmentC.selectedSegmentIndex];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = segmentC.selectedSegmentIndex;
        }];
    }

}
- (NSUInteger)numberOfTabsForViewPager:(ZBViewPagerController *)viewPager
{
    return 2;
}
- (UIViewController *)viewPager:(ZBViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            ZBRemindViewController *noticeVC = [[ZBRemindViewController alloc] init];
            return noticeVC;
        }
            break;
        case 1:
        {
            ZBNoticeViewController *noticeVC = [[ZBNoticeViewController alloc] init];
            return noticeVC;

        }
            break;

        default:
            break;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    if (self.currentIndex != 0 && contentOffsetX <= Width * 1) {
        contentOffsetX += Width * self.currentIndex;
    }
//    NSLog(@"%f",contentOffsetX);
    if (contentOffsetX == Width) {
        _segmentEvent.selectedSegmentIndex = 0;
    }else if (contentOffsetX == Width*2){
        _segmentEvent.selectedSegmentIndex = 1;
    }
    
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
