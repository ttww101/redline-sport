//
//  BaolengZhishuVC.m
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "PageScrollView.h"
#import "TitleIndexView.h"
#import "BaolengTable.h"
#import "BaolengZhishuVC.h"
@interface BaolengZhishuVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>

@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;
//@"全部",@"热门",@"竞彩",@"北单"
@property (nonatomic, strong)BaolengTable *tabelView1;
@property (nonatomic, strong)BaolengTable *tabelView2;
@property (nonatomic, strong)BaolengTable *tabelView3;
@property (nonatomic, strong)BaolengTable *tabelView4;

@end

@implementation BaolengZhishuVC
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
    NavView *nav = [[NavView alloc] init];
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
    
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"全部",@"热门",@"竞彩",@"北单",];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom , Width, Height - _titleView.bottom)];
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

- (BaolengTable *)tabelView1
{
    if (!_tabelView1) {
        _tabelView1 = [[BaolengTable alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView1;
}
- (BaolengTable *)tabelView2
{
    if (!_tabelView2) {
        _tabelView2 = [[BaolengTable alloc]initWithFrame:CGRectMake(Width, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView2;
}
- (BaolengTable *)tabelView3
{
    if (!_tabelView3) {
        _tabelView3 = [[BaolengTable alloc]initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView3;
}
- (BaolengTable *)tabelView4
{
    if (!_tabelView4) {
        _tabelView4 = [[BaolengTable alloc]initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView4;
}
- (UITableView *)pageScrollView:(PageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
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
- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
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
