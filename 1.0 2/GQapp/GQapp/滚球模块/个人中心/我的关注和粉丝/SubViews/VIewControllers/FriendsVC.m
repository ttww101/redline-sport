//
//  FriendsVC.m
//  GQapp
//
//  Created by WQ on 2017/4/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "FriendsVC.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "FansModel.h"
#import "FansTable.h"
@interface FriendsVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;
//粉丝
@property (nonatomic, strong) NSArray *arrFollowers;
//关注
@property (nonatomic, strong) NSArray *arrFocus;
@end

@implementation FriendsVC
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
    self.defaultFailure = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = _selectedIndex;
    _titleView.bottomLineColor = colorDD;
    _titleView.arrData = @[@"关注",@"粉丝"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = _selectedIndex;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
    
    
    [self loadFriendsDataWithIndex:0];
    [self loadFriendsDataWithIndex:1];

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
    if (index== 0) {
        FansTable *table = [[FansTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;
        table.arrData = _arrFocus;
        return table;
        
    }else{
    
        FansTable *table = [[FansTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;

        table.arrData = _arrFollowers;
        return table;

    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
{
    return 2;
}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"我的好友";
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

- (void)loadFriendsDataWithIndex:(NSInteger)index
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"targetId"];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,index == 1? url_followerlist:url_focuslist] Start:^(id requestOrignal) {
        if (index == 0) {
            [LodingAnimateView showLodingView];

        }
    } End:^(id responseOrignal) {
        if (index == 0) {
            [LodingAnimateView dissMissLoadingView];

        }

    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.defaultFailure = @"暂无好友";
            if (index == 0) {
                _arrFocus = [[NSArray alloc] initWithArray:[FansModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];

            }else{
                _arrFollowers = [[NSArray alloc] initWithArray:[FansModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            }
            [_scrollView reloadData];

        }else{
            
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [_scrollView reloadData];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [_scrollView reloadData];
        
        if (index ==0) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }
        
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
