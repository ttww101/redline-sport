//
//  JiaoYiViewController.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/20.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "JiaoYiViewController.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "JiaoYiNewTabelView.h"
#import "JiaoYiModel.h"
@interface JiaoYiViewController ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, retain) JiaoYiNewTabelView *tableView1;
@property (nonatomic, retain) JiaoYiNewTabelView *tableView2;
@property (nonatomic, retain) JiaoYiNewTabelView *tableView3;

//分享

//@property (nonatomic, assign) NSInteger shareIndex;

@end

@implementation JiaoYiViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}

-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _selectedIndex = 0;
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
//    _shareIndex = 3;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"总交易量",@"庄家盈利",@"庄家亏损"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];

    // Do any additional setup after loading the view.
}


- (void)didSelectedAtIndex:(NSInteger)index
{
    [_scrollView updateSelectedIndex:index];
//    switch (index) {
//        case 0:
//            _shareIndex = 3;
//            break;
//        case 1:
//            _shareIndex = 1;
//            break;
//        case 2:
//            _shareIndex = 2;
//            break;
//            
//            
//        default:
//            break;
//    }
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
//    switch (index) {
//        case 0:
//            _shareIndex = 3;
//            break;
//        case 1:
//            _shareIndex = 1;
//            break;
//        case 2:
//            _shareIndex = 2;
//            break;
//            
//            
//        default:
//            break;
//    }
}
- (JiaoYiNewTabelView *)tableView1
{
    if (!_tableView1) {
        _tableView1 = [[JiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView1;
}
- (JiaoYiNewTabelView *)tableView2
{
    if (!_tableView2) {
        _tableView2 = [[JiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView2;
}
- (JiaoYiNewTabelView *)tableView3
{
    if (!_tableView3) {
        _tableView3 = [[JiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView3;
}
- (UITableView *)pageScrollView:(PageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        
        [self.tableView1 updateWithType:3];
        return self.tableView1;
        
    }else if(index == 1){
        
        [self.tableView2 updateWithType:1];
        return self.tableView2;
        
    }else{

        [self.tableView3 updateWithType:2];
        return self.tableView3;
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
{
    return 3;
}
- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"交易冷热";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"shareWhite"] forState:UIControlStateNormal];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"shareWhite"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:nav];
    
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
//        NSLog(@"%@",[NSString stringWithFormat:@"%@/share/v5.0/jiaoyi.html?type=%ld",APPDELEGATE.url_jsonHeader,_shareIndex]);
//        if (![Methods login]) {
//            [Methods toLogin];
//            return;
//        }
//        _shareViews = [[ShareView alloc] initWithViewController:self];
//        _shareViews.shareWebUrl = [NSString stringWithFormat:@"%@%@jiaoyi.html?type=%ld",APPDELEGATE.url_jsonHeader,url_share,_shareIndex];
//        _shareViews.shareImageUrl = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,url_shareImage(@"applogo")];
//        _shareViews.shareTitle = @"交易冷热【滚球体育】";
//        _shareViews.shareContent = @"更多数据、情报、推荐资讯请下载滚球体育";
//        [_shareViews shareViewShow];
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
