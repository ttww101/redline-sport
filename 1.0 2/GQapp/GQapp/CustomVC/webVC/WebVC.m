//
//  WebVC.m
//  GQapp
//
//  Created by WQ on 2016/11/30.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebVC
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
    [self.view addSubview:self.webView];
    self.navigationItem.title = _strtitle;
    [self setNavView];
}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = _strtitle;
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



- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
        _webView.opaque = NO;
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strurl]]];
        //        NSLog(@"%@",_url);
        
    }
    return _webView;
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
