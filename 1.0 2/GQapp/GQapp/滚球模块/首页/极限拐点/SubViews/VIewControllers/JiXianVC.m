//
//  JiXianVC.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "JiXianVC.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "JiXianTableView.h"
#import "Record_OneModel.h"

@interface JiXianVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>

@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;
//胜平负 亚盘 大小球
@property (nonatomic, strong)JiXianTableView *tabelView1;
@property (nonatomic, strong)JiXianTableView *tabelView2;
@property (nonatomic, strong)JiXianTableView *tabelView3;

//分享


@end

@implementation JiXianVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"胜平负",@"亚盘",@"大小球"];
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

- (JiXianTableView *)tabelView1
{
    if (!_tabelView1) {
        _tabelView1 = [[JiXianTableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView1;
}
- (JiXianTableView *)tabelView2
{
    if (!_tabelView2) {
        _tabelView2 = [[JiXianTableView alloc]initWithFrame:CGRectMake(Width, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView2;
}
- (JiXianTableView *)tabelView3
{
    if (!_tabelView3) {
        _tabelView3 = [[JiXianTableView alloc]initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _tabelView3;
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
        
    }else{
        
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
    nav.labTitle.text = @"极限拐点";
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
        

//        if (![Methods login]) {
//            [Methods toLogin];
//            return;
//        }
//        _shareViews = [[ShareView alloc] initWithViewController:self];
//        _shareViews.shareWebUrl = [NSString stringWithFormat:@"%@%@zhanji.html?oddstype=%ld&type=%ld",APPDELEGATE.url_jsonHeader,url_share,_selectedIndex,_btnSelectIndex];
//        _shareViews.shareImageUrl = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,url_shareImage(@"applogo")];
//        _shareViews.shareTitle = @"极限拐点【滚球情报】";
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
