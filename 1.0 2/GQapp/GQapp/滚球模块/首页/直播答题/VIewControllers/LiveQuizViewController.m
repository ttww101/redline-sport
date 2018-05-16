//
//  LiveQuizViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "LiveQuizViewController.h"
#import "WebViewJavascriptBridge.h"
#import "LiveQuizWithDrawalViewController.h"
#import "CouponListViewController.h"
#import "ToolWebViewController.h"
#import "LiveQuizAlertView.h"
#import "AppManger.h"
#import "JSModel.h"

@interface LiveQuizViewController () <UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@property (nonatomic , copy) GQJSResponseCallback callBack;

@property (nonatomic , assign) BOOL showLoding;

@property (nonatomic , strong) AppManger *manger;


@end

@implementation LiveQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showLoding = YES;
    [self configUI];
    [self loadBradgeHandler];
    [self loadData];
    
    __block __weak id gpsObserver;
    gpsObserver = [[NSNotificationCenter defaultCenter]addObserverForName:@"userLoginNotification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self userLogin];
        [[NSNotificationCenter defaultCenter] removeObserver:gpsObserver];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    if ([_model.title isEqualToString:@"直播答题"]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if ([_model.title isEqualToString:@"直播答题"]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:false];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - notification

- (void)userLogin {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_webView) {
            _webView = nil;
            [_webView removeFromSuperview];
        }
        [self configUI];
        [self loadBradgeHandler];
        [self loadData];
    });
}

#pragma mark - Config UI

- (void)configUI {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.title = _model.title;
    adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
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
        [request setValue:PARAM_IS_NIL_ERROR([Methods getTokenModel].token) forHTTPHeaderField:@"token"];
        [self.webView loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}

- (void)loadBradgeHandler {
    __weak LiveQuizViewController *weakSelf = self;
    
    self.bridge = [self.manger registerJSTool:self.webView hannle:^(id data, GQJSResponseCallback responseCallback) {
        if (responseCallback) {
            weakSelf.callBack = responseCallback;
        }
        JSModel *model = (JSModel *)data;
        NSString *actionString = model.methdName;
        SEL action = NSSelectorFromString(actionString);
        
        if ([self respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakSelf performSelector:action withObject:model.parameterData];
#pragma clang diagnostic pop
        }
    }];
    
    [self.bridge setWebViewDelegate:self];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (self.showLoding) {
        [LodingAnimateView showLodingView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.showLoding) {
        [LodingAnimateView dissMissLoadingView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    if (self.showLoding) {
        [LodingAnimateView dissMissLoadingView];
    }
}

#pragma mark - JSHandle

- (void)back:(id)parameter {
    if ([parameter integerValue] == 0) {
        self.callBack(@"1");
        self.showLoding = false;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dialog:(id)parameter {
    NSData *jsonData = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    [LiveQuizAlertView showPaymentInfo:dic animations:YES selectOption:^(id selectAction) {
        if (selectAction) {
            self.callBack(@"1");
            self.showLoding = false;
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)open:(id)parameter {
    NSString *targetClass = parameter;
    Class targetCalss = NSClassFromString(targetClass);
    id target = [[targetCalss alloc] init];
    if (target == nil) {
        [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
        return;
    } else {
        [self.navigationController pushViewController:target animated:YES];
    }
}

#pragma mark - Action

- (BOOL)panAction:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

#pragma mark - Lazy Load

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        _webView.scrollView.scrollEnabled = false;
        [_webView setMediaPlaybackRequiresUserAction:NO];
        [_webView setScalesPageToFit:YES];
    }
    return _webView;
}

- (AppManger *)manger {
    if (_manger == nil) {
        _manger = [[AppManger alloc]init];
    }
    return _manger;
}

@end
