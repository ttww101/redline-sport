//
//  TongjiVC.m
//  GQapp
//
//  Created by WQ on 2017/4/27.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "TongjiVC.h"
#import "RoundUserView.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "WebViewJavascriptBridge.h"
#import "UsercatestatisModel.h"

@interface TongjiVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;

//周月总数据
@property (nonatomic, strong) UsercatestatisModel *modelWeek;
@property (nonatomic, strong) UsercatestatisModel *modelmonth;
@property (nonatomic, strong) UsercatestatisModel *modelTotal;

@property (nonatomic, strong) UIWebView *webViewWee;
@property (nonatomic, strong) UIWebView *webViewMon;
@property (nonatomic, strong) UIWebView *webViewAll;
@property WebViewJavascriptBridge* bridgeWee;
@property WebViewJavascriptBridge* bridgeMon;
@property WebViewJavascriptBridge* bridgeAll;

@end

@implementation TongjiVC
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar - 44, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.bottomLineColor = colorDD;
    _titleView.arrData = @[@"周统计",@"月统计",@"总统计"];
    
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
    [self setNavView];
    
    [self loadDataWithType:self.tongjiType];
//    [self loadDataWithType:1];
//    [self loadDataWithType:2];
    
    
    
//    RoundUserView *round = [[RoundUserView alloc] initWithFrame:self.view.bounds];
//    round.backgroundColor = redcolor;
//    [self.view addSubview:round];

    
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
}
- (UIWebView *)webViewWee{
    if (!_webViewWee) {
        _webViewWee = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, _scrollView.height)];
        _bridgeWee = [WebViewJavascriptBridge bridgeForWebView:_webViewWee];
        _webViewWee.backgroundColor = colorTableViewBackgroundColor;
    }
    
    return _webViewWee;
}
- (UIWebView *)webViewMon{
    if (!_webViewMon) {
        _webViewMon = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, _scrollView.height)];
        _bridgeMon = [WebViewJavascriptBridge bridgeForWebView:_webViewMon];
        _webViewMon.backgroundColor = colorTableViewBackgroundColor;
    }
    return _webViewMon;
}
- (UIWebView *)webViewAll{
    if (!_webViewAll) {
        _webViewAll = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, _scrollView.height)];
        _bridgeAll = [WebViewJavascriptBridge bridgeForWebView:_webViewAll];
        _webViewAll.backgroundColor = colorTableViewBackgroundColor;
    }
    return _webViewAll;

}
- (UIView *)pageScrollView:(PageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{

//    switch (index) {
//        case 0:
//        {
//            return self.webViewAll;
//            
//        }
//            break;
//        case 1:
//        {
//            return self.webViewMon;
//        }
//            break;
//        case 2:
//        {

            return self.webViewWee;
//        }
//            break;
//
//        default:
//            break;
//    }

     return [UITableView new];
    
}
- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
{
    return 1;
}



#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    
    UserModel *user = [Methods getUserModel];
    if (user.idId != _userModel.idId) {
        nav.labTitle.text =[NSString stringWithFormat:@"%@的统计",_userModel.nickname];

    }else{
        nav.labTitle.text =[NSString stringWithFormat:@"%@的统计",@"我"];

    }
    
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
       [self.view addSubview:nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){}
}


- (void)loadDataWithType:(NSInteger)selectedType
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userModel.idId] forKey:@"userId"];
//        [parameter setObject:[NSString stringWithFormat:@"%d",30318] forKey:@"userId"];
    
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)selectedType] forKey:@"type"];
    
    [[DCHttpRequest shareInstance]sendHtmlGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server, _tongjiType ==0? url_ucenterusercatestatis : url_quizmyQuizStatis] Start:^(id requestOrignal) {
        
//        if (selectedType == 0) {
            [LodingAnimateView showLodingView];

//        }
        
        
        
        
    } End:^(id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];

    } Success:^(id responseResult, id responseOrignal) {
            
//            switch (selectedType) {
//                case 0:
//                {

                    NSString* path = [[NSBundle mainBundle] pathForResource:@"chengji-list" ofType:@"html"];
                    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                    [self.webViewWee loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
                    NSArray *arr = [[NSArray alloc] initWithObjects:responseOrignal,@{@"type":@"0"}, nil];
                    [_bridgeWee callHandler:@"chengji" data:arr responseCallback:^(id response) {
                        NSLog(@"testJavascriptHandler responded: %@", response);
                    }];
                    
                    [self.webViewWee reload];
                    [self.scrollView reloadData];
                    
//                }
//                    break;
//                case 1:
//                {
//                    NSString* path = [[NSBundle mainBundle] pathForResource:@"chengji-list" ofType:@"html"];
//                    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//                    [self.webViewMon loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
//                    NSArray *arr = [[NSArray alloc] initWithObjects:responseOrignal,@{@"type":@"1"}, nil];
//                    [_bridgeMon callHandler:@"chengji" data:arr responseCallback:^(id response) {
//                        NSLog(@"testJavascriptHandler responded: %@", response);
//                    }];
//                    
//                    [self.webViewMon reload];
//                    [self.scrollView reloadData];
//                }
//                    break;
//                case 2:
//                {
//                    NSArray *arr = [[NSArray alloc] initWithObjects:responseOrignal,@{@"type":@"2"}, nil];
//                    NSString* path = [[NSBundle mainBundle] pathForResource:@"chengji-list" ofType:@"html"];
//                    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//                    [self.webViewAll loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
//                    [_bridgeAll callHandler:@"chengji" data:arr responseCallback:^(id response) {
//                        NSLog(@"testJavascriptHandler responded: %@", response);
//                    }];
//                    
//                    [self.webViewAll reload];
//                    [self.scrollView reloadData];
//                }
//                    break;
//                    
//                default:
//                    break;
//            }
        
        
            
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

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
