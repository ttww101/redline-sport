//
//  UserTuijianVC.m
//  GQapp
//
//  Created by WQ on 2017/4/26.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "UserTuijianVC.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "UserTuijianTable.h"
@interface UserTuijianVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;

@end

@implementation UserTuijianVC
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
    [self setNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.arrData = @[@"全部",@"胜平负",@"亚盘",@"大小球"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];

}
- (void)didSelectedAtIndex:(NSInteger)index
{
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
}
- (UITableView *)pageScrollView:(PageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    UserTuijianTable *table = [[UserTuijianTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.userId = _userId;
    table.oddtype = index;
    [table loadNewData];
    return table;
    return [UITableView new];
    
}
- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
{
    return 4;
}



#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    
    UserModel *user = [Methods getUserModel];
    if (user.idId == _userId) {
        nav.labTitle.text = @"推荐记录" ;

    }else{
        nav.labTitle.text = [NSString stringWithFormat:@"%@的推荐",_userName] ;
//        nav.labTitle.text = @"Ta的推荐" ;

    }
    
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
