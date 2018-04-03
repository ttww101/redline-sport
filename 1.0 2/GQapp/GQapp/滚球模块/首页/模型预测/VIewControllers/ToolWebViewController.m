//
//  ToolWebViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ToolWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "UserModel.h"
#import "TokenModel.h"


@interface ToolWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@end

@implementation ToolWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadBradge];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData {
    if (_model) {
        self.urlPath = _model.webUrl;
        self.html5Url = _model.htmlUrl;
    }
    
    if (self.urlPath != nil) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSURL *url = [NSURL URLWithString:self.urlPath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.timeoutInterval = 15;
        [self.webView loadRequest:request];
    } else if (self.html5Url != nil) {
        [self.webView loadHTMLString:self.html5Url baseURL:nil];
    }
}

#pragma mark - Config UI

- (void)configUI {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.title = _model.title;
    adjustsScrollViewInsets_NO(self.webView.scrollView, self);
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@",request);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [LodingAnimateView showLodingView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [LodingAnimateView dissMissLoadingView];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    [LodingAnimateView dissMissLoadingView];
    
}

#pragma mark -

- (void)loadBradge {
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    NSString *token = [Methods getTokenModel].token;
    
    if ([_model.title isEqualToString:@"胜平负"] || [_model.title isEqualToString:@"亚盘"] || [_model.title isEqualToString:@"大小球"]) {
        [self.bridge callHandler:_model.callHandleActionName data:token responseCallback:^(id responseData) {
            NSLog(@"%@",responseData);
        }];
        
        
        [self.bridge registerHandler:@"toPage" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self responseRegisterAction:data];
            responseCallback(@"Response from testObjcCallback");
        }];
    }

    if (_model.parameter) {
        [self.bridge callHandler:_model.callHandleActionName data:_model.parameter responseCallback:^(id responseData) {
            NSLog(@"%@",responseData);
        }];
    }
}

// type 1 单场 0 开通服务

- (void)responseRegisterAction:(id)data {
    NSString *weakToken = [Methods getTokenModel].token;
    NSDictionary *dic = (NSDictionary *)data;
    WebModel *webModel = [[WebModel alloc]init];
    webModel.title = dic[@"name"];
    NSString *url = dic[@"url"];
    webModel.webUrl = [NSString stringWithFormat:@"%@:81/ios/%@", APPDELEGATE.url_jsonHeader ,url];
    webModel.callHandleActionName = dic[@"model"];
    if ([dic[@"type"] isEqualToString:@"1"]) {
        NSMutableDictionary *parametr = [[NSMutableDictionary alloc]init];
        [parametr setObject:weakToken forKey:@"token"];
        [parametr setObject:dic[@"homeTeam"] forKey:@"homeTeam"];
        [parametr setObject:dic[@"guestTeam"] forKey:@"guestTeam"];
        [parametr setObject:dic[@"scheduleId"] forKey:@"scheduleId"];
        webModel.parameter = parametr;
    }
    ToolWebViewController *control = [[ToolWebViewController alloc]init];
    control.model = webModel;
    [self.navigationController pushViewController:control animated:YES];
   
}

#pragma mark - Lazy Load

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _webView;
}

@end
