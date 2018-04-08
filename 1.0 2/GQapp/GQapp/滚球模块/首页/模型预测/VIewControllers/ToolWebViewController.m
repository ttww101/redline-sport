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
#import "AppleIAPService.h"


@interface ToolWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@end

@implementation ToolWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_webView) {
        _webView = nil;
        [_webView removeFromSuperview];
    }
    [self configUI];
    [self loadBradge];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeWebCache{
    //先删除cookie
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
    NSString *cookiesFolderPath = [libraryDir stringByAppendingString:@"/Cookies"];
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&error];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
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
        
        }];
        // 内购方法
        [self.bridge registerHandler:_model.registerActionName handler:^(id data, WVJBResponseCallback responseCallback) {
            [[AppleIAPService sharedInstance]purchase:data[@"type"] resultBlock:^(NSString *message, NSError *error) {
                if (error) {
                    NSString *errMse = error.userInfo[@"NSLocalizedDescription"];
                    [SVProgressHUD showErrorWithStatus:errMse];
                } else{
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }];
        
        [self.bridge registerHandler:@"toPage" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self responseRegisterAction:data];
            responseCallback(@"Response from testObjcCallback");
        }];
    }
}

// 0 大小球开通服务，  1 单场解密， 2 历史记录， 3 值投赛事， 4 最高连红， 5 值投赛事详情， 6 历史记录详情
- (void)responseRegisterAction:(id)data {
    NSString *weakToken = [Methods getTokenModel].token;
    NSDictionary *dic = (NSDictionary *)data;
    WebModel *webModel = [[WebModel alloc]init];
    webModel.title = dic[@"name"];
    NSString *url = dic[@"url"];
    webModel.webUrl = [NSString stringWithFormat:@"%@:81/ios/%@", APPDELEGATE.url_jsonHeader ,url];
    webModel.callHandleActionName = dic[@"model"];
    webModel.registerActionName = @"payAction";
    NSMutableDictionary *parametr = [[NSMutableDictionary alloc]init];
    [parametr setObject:weakToken forKey:@"token"];
    if ([dic[@"type"] isEqualToString:@"0"]) {
        
    } else if ([dic[@"type"] isEqualToString:@"1"]) {
        [parametr setObject:dic[@"homeTeam"] forKey:@"homeTeam"];
        [parametr setObject:dic[@"guestTeam"] forKey:@"guestTeam"];
        [parametr setObject:dic[@"scheduleId"] forKey:@"scheduleId"];
    } else if ([dic[@"type"] isEqualToString:@"2"]) {
        
    } else if ([dic[@"type"] isEqualToString:@"3"]) {
        
    } else if ([dic[@"type"] isEqualToString:@"4"]) {
        [parametr setObject:dic[@"count"] forKey:@"count"];
    } else if ([dic[@"type"] isEqualToString:@"5"]) {
        [parametr setObject:dic[@"id"] forKey:@"id"];
    }  else if ([dic[@"type"] isEqualToString:@"6"]) {
        [parametr setObject:dic[@"week"] forKey:@"week"];
        [parametr setObject:dic[@"id"] forKey:@"id"];
    }
    webModel.parameter = parametr;
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
