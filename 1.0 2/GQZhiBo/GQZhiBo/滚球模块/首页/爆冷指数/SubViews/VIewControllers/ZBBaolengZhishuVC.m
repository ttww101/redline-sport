//
//  ZBBaolengZhishuVC.m
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "ZBPageScrollView.h"
#import "ZBTitleIndexView.h"
#import "ZBBaolengTable.h"
#import "ZBBaolengZhishuVC.h"
@interface ZBBaolengZhishuVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>

@property (nonatomic, strong) ZBPageScrollView *scrollView;
@property (nonatomic, strong) ZBTitleIndexView *titleView;
//@"全部",@"热门",@"竞彩",@"北单"
@property (nonatomic, strong)ZBBaolengTable *tabelView1;
@property (nonatomic, strong)ZBBaolengTable *tabelView2;
@property (nonatomic, strong)ZBBaolengTable *tabelView3;
@property (nonatomic, strong)ZBBaolengTable *tabelView4;

@end

@implementation ZBBaolengZhishuVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"爆冷指数";
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"全部",@"热门",@"竞彩",@"北单",];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[ZBPageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom , Width, Height - _titleView.bottom)];
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

- (ZBBaolengTable *)tabelView1
{
    if (!_tabelView1) {
        _tabelView1 = [[ZBBaolengTable alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView1;
}
- (ZBBaolengTable *)tabelView2
{
    if (!_tabelView2) {
        _tabelView2 = [[ZBBaolengTable alloc]initWithFrame:CGRectMake(Width, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView2;
}
- (ZBBaolengTable *)tabelView3
{
    if (!_tabelView3) {
        _tabelView3 = [[ZBBaolengTable alloc]initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView3;
}
- (ZBBaolengTable *)tabelView4
{
    if (!_tabelView4) {
        _tabelView4 = [[ZBBaolengTable alloc]initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView4;
}
- (UITableView *)pageScrollView:(ZBPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        
        [self.tabelView1 updateWithType:0];
        return self.tabelView1;
        
    }else if(index == 1){
        
        
        [self.tabelView2 updateWithType:1];
        return self.tabelView2;
        
    }else if(index == 2){
        
        
        [self.tabelView3 updateWithType:2];
        return self.tabelView3;
        
    }else if(index == 3){
        
        
        [self.tabelView4 updateWithType:3];
        return self.tabelView4;
        
    }else{
        
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(ZBPageScrollView *)pageScroll
{
    return 4;
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
