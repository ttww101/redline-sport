//
//  ZBNoticeDetailViewController.m
//  GQapp
//
//  Created by WQ_h on 16/4/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBNoticeDetailViewController.h"
@interface ZBNoticeDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
//分享

@end

@implementation ZBNoticeDetailViewController

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
    nav.labTitle.text = @"通知";
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
//        if (![ZBMethods login]) {
//            [ZBMethods toLogin];
//            return;
//        }
//        _shareViews = [[ShareView alloc] initWithViewController:self];
//        _shareViews.shareWebUrl = [NSString stringWithFormat:@"http://mobile.gunqiu.com/share/tongzhi.html?mid=%ld&flag=3",(long)_model.mid];
//        _shareViews.shareImageUrl =[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,url_shareImage(@"applogo")];
//        _shareViews.shareTitle = _model.title;
//        _shareViews.shareContent = _model.content;
//        [_shareViews shareViewShow];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavView];
//    UILabel *labContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
//    labContent.textColor = grayColor34;
//    labContent.font = font13;
//    labContent.numberOfLines = 0;
////    labContent.text = _model.content;
//    
////     NSString * htmlString = @"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
//     NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    labContent.attributedText =attrStr;
//    [self.view addSubview:labContent];
    
    
    [self.view addSubview:self.webView];
}
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
        _webView.opaque = NO;
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/notice/%ld.html",APPDELEGATE.url_ServerWWW,(long)_model.mid]]]];
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
