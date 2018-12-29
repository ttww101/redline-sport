#import "ZBToolWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "ZBUserModel.h"
#import "ZBTokenModel.h"
#import "ZBAppleIAPService.h"
#import <UShareUI/UShareUI.h>
#import "ZBCouponListViewController.h"
#import "ZBLiveQuizWithDrawalViewController.h"
#import "XHPayKit.h"
#import "ArchiveFile.h"
#import "ZBAppManger.h"
#import "ZBNavImageView.h"
#import "ZBWebView.h"
#import "ZBLiveQuizViewController.h"
#import "ZBLotteryWebViewController.h"
#import "ZBCommentsView.h"
#import "ZBCommentsViewController.h"
#import "ZBInputViewController.h"
#import "ZBReplyViewController.h"
#import "GeneralFloatingView.h"

@interface ZBToolWebViewController () <UIWebViewDelegate, GQWebViewDelegate, WKUIDelegate,WKNavigationDelegate, CommentsViewDelegate, GeneralFloatingViewDelegate, UIWebViewDelegate>
@property (nonatomic , strong) WebViewJavascriptBridge* bridge;
@property (nonatomic , copy) GQJSResponseCallback callBack;
@property (nonatomic , copy) NSString *recordUrl;
@property (nonatomic , assign) BOOL isToFenxi;
@property (nonatomic, assign) BOOL isBack;
@property (nonatomic , strong) UIView *toastView;
@property (nonatomic , weak) id observer;
@property (nonatomic , strong) ZBWebView *activityWeb;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic , strong) ZBCommentsView *commentsView;
@property (nonatomic , strong) NSDictionary *commentsDic;
@property (nonatomic , strong) UIButton *replyBtn;
@property (nonatomic , strong) GeneralFloatingView *floatingView;
@property (nonatomic, assign) BOOL useWkWeb;


@end
#define wxpay @"wx"
#define alipay @"ali"
@implementation ZBToolWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.model.webUrl containsString:@"pay-for.html"] || [self.model.webUrl containsString:@"buy-diamond.html"] || [self.model.webUrl containsString:@"buy-gold.html"]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshResult) name:@"refreshPayPage" object:nil];
    }
    
    if ([self.model.webUrl containsString:@"index"]) {
        self.useWkWeb = false;
        
    } else {
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, Width, 2)];
        self.progressView.progressTintColor = redcolor;
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.wkWeb addSubview:self.progressView];
        [self.wkWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        self.useWkWeb = true;
    }
    
    
    [self configUI];
    [self loadBradgeHandler];
    [self loadData];
    if ([self.model.webUrl containsString:@"tuijianIndex"]) {
        [self.view addSubview:self.floatingView];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    [self configWebHeight];
    if (self.isBack) {
        if (self.progressView.hidden) {
            [self refreshData];
        }
    }
    [MobClick beginLogPageView:PARAM_IS_NIL_ERROR(_model.title)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (_commentsView) {
            [_commentsView loadData];
        }
    });
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isBack = YES;
    [MobClick endLogPageView:PARAM_IS_NIL_ERROR(_model.title)];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    if (self.useWkWeb) {
        [self.wkWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.wkWeb = nil;
    self.bridge = nil;
}
#pragma mark - Notification
- (void)refreshResult {
    if ([[NSUserDefaults standardUserDefaults]objectForKey:wxpay] || [[NSUserDefaults standardUserDefaults]objectForKey:alipay]) {
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"payResult"}];
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        }];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:wxpay];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
- (void)refreshData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"reload"}];
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        }];
    });
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWeb.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    if ([url.absoluteString hasPrefix:@"weixin://"]) {
        [[UIApplication sharedApplication]openURL:url];
    } else if ([url.absoluteString hasPrefix:@"alipay://"]) {
        [[UIApplication sharedApplication]openURL:url];
    }
    
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = YES;
    [self dissMissToastView];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
    if (error.code == -999) {
        return;
    }
    if (error.code == -1002) {
        return;
    }
    [self createNullToastView:@"" imageName:@"nodataFirstP"];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)); {
    [webView reload];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self dissMissToastView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code == -999) {
        return;
    }
    if (error.code == -1002) {
        return;
    }
    [self createNullToastView:@"" imageName:@"nodataFirstP"];
}

#pragma mark - CommentsViewDelegate


- (void)commentViewDidSelectCommnetList:(ZBCommentsView *)commentView {
    if (self.commentsDic) {
        NSDictionary *dic = self.commentsDic[@"comment"];
        ZBCommentsViewController *control = [[ZBCommentsViewController alloc]init];
        control.ID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        control.module = dic[@"module"];
        [self.navigationController pushViewController:control animated:YES];
    }
}
- (void)commentViewDidSelectReply:(ZBCommentsView *)commentView {
    if (self.commentsDic) {
        NSDictionary *dic = self.commentsDic[@"comment"];
        ZBInputViewController *control = [[ZBInputViewController alloc]init];
        control.newsid = [NSString stringWithFormat:@"%@",dic[@"id"]];
        control.moduleid = dic[@"module"];
        control.parentid = @"0";
        [self.navigationController pushViewController:control animated:YES];
    }
}
- (void)commentViewDidSelectShare:(ZBCommentsView *)commentView {
    if (self.commentsDic) {
        NSDictionary *dic = self.commentsDic[@"share"];
        [self webShare:dic];
    }
}
#pragma mark - Load Data
- (void)loadBradgeHandler {
    __weak ZBToolWebViewController *weakSelf = self;
    ZBAppManger *manger = [[ZBAppManger alloc]init];
    WebViewJavascriptBridge *bridge ;
    if (self.useWkWeb) {
      bridge = [manger WK_RegisterJSTool:self.wkWeb hannle:^(id data, GQJSResponseCallback responseCallback) {
            if (responseCallback) {
                weakSelf.callBack = responseCallback;
            }
            ZBJSModel *model = (ZBJSModel *)data;
            NSString *actionString = model.methdName;
            SEL action = NSSelectorFromString(actionString);
            if ([weakSelf respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [weakSelf performSelector:action withObject:model.parameterData];
#pragma clang diagnostic pop
            }
        }];
    } else {
        bridge = [manger registerJSTool:self.webView hannle:^(id data, GQJSResponseCallback responseCallback) {
            if (responseCallback) {
                weakSelf.callBack = responseCallback;
            }
            ZBJSModel *model = (ZBJSModel *)data;
            NSString *actionString = model.methdName;
            SEL action = NSSelectorFromString(actionString);
            if ([weakSelf respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [weakSelf performSelector:action withObject:model.parameterData];
#pragma clang diagnostic pop
            }
        }];
    }
    [bridge setWebViewDelegate:self];
    self.bridge = bridge;
}
- (void)loadData {
    if (_model) {
        self.urlPath = _model.webUrl;
        self.html5Url = _model.htmlUrl;
        if (_recordUrl) {
            self.urlPath = _recordUrl;
            self.html5Url = _recordUrl;
        }
    }
    if (self.urlPath != nil) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSURL *url = [NSURL URLWithString:self.urlPath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
        [request setValue:PARAM_IS_NIL_ERROR([ZBMethods getTokenModel].token) forHTTPHeaderField:@"token"];
        if (self.useWkWeb) {
            [self.wkWeb loadRequest:request];
        } else {
            [self.webView loadRequest:request];
        }
        
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.wkWeb loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}
#pragma mark - Config UI
- (void)configWebHeight {
    if (self.navigationController.navigationBarHidden) {
        self.wkWeb.frame = CGRectMake(0, 0, self.view.width, Height - (_model.fromTab ? 49:0));
    } else {
        self.wkWeb.frame = CGRectMake(0, 0, self.view.width, Height - 64 - (_model.fromTab ? 49:0));
    }
    self.webView.frame = self.wkWeb.frame;
}
- (void)configUI {
    if (self.useWkWeb) {
         [self.view addSubview:self.wkWeb];
         adjustsScrollViewInsets_NO(self.wkWeb.scrollView, self);
    } else {
         [self.view addSubview:self.webView];
         adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    }
   
    self.navigationItem.title = _model.title;
   
    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    if (_model.showBuyBtn) {
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyBtn setTitle:@"开通服务" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.frame = CGRectMake(0, 0, 70, 44);
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buyBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    if (self.navigationController.navigationBarHidden) {
    } else {
        if ([_model.parameter isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic = _model.parameter;
            NSDictionary *navDic = dataDic[@"nav"];
            if (!([navDic isKindOfClass:[NSDictionary class]] && navDic.allKeys.count > 0)) {
                return;
            }
            NSArray *leftArray = navDic[@"left"];
            NSArray *rightArray = navDic[@"right"];
            if (leftArray.count > 0) {
                NSMutableArray *leftItemsArray = [NSMutableArray new];
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    NSDictionary *dic = leftArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    ZBNavImageView *imageV = [[ZBNavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.image = [imageV.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    imageV.clipsToBounds = YES;
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    imageV.contentMode = UIViewContentModeScaleAspectFit;
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [leftItemsArray addObject:item];
                }
                self.navigationItem.leftBarButtonItems = [leftItemsArray copy];
            }
            if (rightArray.count > 0) {
                NSMutableArray *rightItemsArray = [NSMutableArray new];
                rightArray = [[rightArray reverseObjectEnumerator] allObjects];
                for (NSInteger i = 0; i < rightArray.count; i ++) {
                    NSDictionary *dic = rightArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    ZBNavImageView *imageV = [[ZBNavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    imageV.contentMode = UIViewContentModeScaleAspectFit;
                    [rightItemsArray addObject:item];
                }
                self.navigationItem.rightBarButtonItems = rightItemsArray;
            }
        }
    }
}
#pragma mark - GQWebViewDelegate
- (void)webClose:(id)data {
    if (_activityWeb) {
        [_activityWeb removeFromSuperview];
        _activityWeb = nil;
    }
}

#pragma mark - GeneralFloatingViewDelegate

- (void)floatingViewDidSelected:(NSInteger)sender {
    if (sender == 0) {
        if(![ZBMethods login]) {
            [ZBMethods toLogin];
            return;
        }
        ZBFabuTuijianSelectedItemVC *control= [[ZBFabuTuijianSelectedItemVC alloc]init];
        [self.navigationController pushViewController:control animated:true];
    } else {
        if (_wkWeb) {
            [_wkWeb removeFromSuperview];
            _wkWeb = nil;
            self.bridge = nil;
            [self.wkWeb addSubview:self.progressView];
            [self.wkWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
            [self configUI];
            [self loadBradgeHandler];
            [self loadData];
            [self.view bringSubviewToFront:self.floatingView];
        }
    }
}

#pragma mark - JSHandle
- (void)closeWin:(id)data {
}

- (void)webBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webShare:(id)data {
    if ([data isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSString *title = dic[@"title"];
        NSString *picurl = dic[@"picurl"];
        NSString *des = dic[@"des"];
        NSString *linkurl = dic[@"linkurl"];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            switch (platformType) {
                case UMSocialPlatformType_Sina: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装新浪客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_WechatSession: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_WechatTimeLine: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatTimeLine]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_QQ: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_Qzone: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Qzone]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                default:
                    break;
            }
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:des thumImage:picurl];
            shareObject.webpageUrl = linkurl;
            messageObject.shareObject = shareObject;
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[ZBMethods help_getCurrentVC] completion:^(id data, NSError *error) {
                if (error) {
                    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shareFailed", @"val":@(platformType)}];
                    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                    }];
                }else{
                    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shareSuccess", @"val":@(platformType)}];
                    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                    }];
                }
            }];
        }];
    }
}
- (void)back:(id)parameter {
    if ([parameter integerValue] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)openH5:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        ZBWebModel *webModel = [[ZBWebModel alloc]init];
        webModel.title = dic[@"title"];
        webModel.webUrl =  dic[@"url"];
        webModel.hideNavigationBar = false;
        ZBToolWebViewController *control = [[ZBToolWebViewController alloc]init];
        control.model = webModel;
        [self.navigationController pushViewController:control animated:YES];
    }
}
- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
        className = [NSString stringWithFormat:@"ZB%@",className];
        if ([className isEqualToString:@"ZBGQMineViewController"]) {
            className = @"ZBMineViewController";
        }
        if ([className isEqualToString:@"ZBFenxiPageVC"]) {
            [self pushToMatchDetail:dataDic];
            return;
        }
        if ([className isEqualToString:@"ZBBifenViewController"]) {
            [self.tabBarController setSelectedIndex:1];
            return;
        }
        if ([className isEqualToString:@"ZBNewQingBaoViewController"]) {
            [self.tabBarController setSelectedIndex:2];
            return;
        }
        if ([className isEqualToString:@"ZBLiveQuizViewController"]) {
            ZBWebModel *model = [[ZBWebModel alloc]init];
            NSDictionary *vDic = dataDic[@"v"];
            model.title = PARAM_IS_NIL_ERROR(vDic[@"title"]);
            model.webUrl = PARAM_IS_NIL_ERROR(vDic[@"url"]);
            model.hideNavigationBar = YES;
            ZBLiveQuizViewController *controller = [[ZBLiveQuizViewController alloc]init];
            controller.model = model;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        if ([className isEqualToString:@"ZBLotteryWebViewController"]) {
            ZBWebModel *model = [[ZBWebModel alloc]init];
            NSDictionary *vDic = dataDic[@"v"];
            model.title = PARAM_IS_NIL_ERROR(vDic[@"title"]);
            model.webUrl = PARAM_IS_NIL_ERROR(vDic[@"url"]);
            model.hideNavigationBar = [vDic[@"nav_hidden"] integerValue];
            ZBLotteryWebViewController *controller = [[ZBLotteryWebViewController alloc]init];
            controller.model = model;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        if ([className isEqualToString:@"GQRedBombActivity"]) {
            ZBWebModel *model = [[ZBWebModel alloc]init];
            NSDictionary *vDic = dataDic[@"v"];
            model.title = PARAM_IS_NIL_ERROR(vDic[@"title"]);
            model.webUrl = PARAM_IS_NIL_ERROR(vDic[@"url"]);
            model.hideNavigationBar = YES;
            ZBWebView *web = [[ZBWebView alloc]init];
            web.webDelegate = self;
            web.frame = [UIScreen mainScreen].bounds;
            web.model = model;
            web.opaque = NO;
            web.backgroundColor = [UIColor clearColor];
            web.scrollView.scrollEnabled = false;
            [[ZBMethods getMainWindow] addSubview:web];
            _activityWeb = web;
            return;
        }
        if ([className isEqualToString:@"ZBFabuTuijianSelectedItemVC"]) {
            [MobClick event:@"tjdtftj" label:@""];
            if (![ZBMethods login]) {
                [ZBMethods toLogin];
                return;
            }
        }
        if ([className isEqualToString:@"ZBSearchViewController"]) {
            [MobClick event:@"tjdtss" label:@""];
        }
        if ([self containsClassName:className]) {
            UIViewController *controller =[self indexWithClassName:className];
            if (controller) {
                [self.navigationController popToViewController:controller animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } else {
            Class targetCalss = NSClassFromString(className);
            id target = [[targetCalss alloc] init];
            if (target == nil) {
                [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
                return;
            } else {
                unsigned int outCount = 0;
                NSMutableArray *keyArray = [NSMutableArray array];
                objc_property_t *propertys = class_copyPropertyList([targetCalss class], &outCount);
                for (unsigned int i = 0; i < outCount; i ++) {
                    objc_property_t property = propertys[i];
                    NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                    [keyArray addObject:propertyName];
                }
                free(propertys);
                NSDictionary *parameterDic = dataDic[@"v"];
                if (parameterDic.allKeys.count > 0) {
                    NSArray *array = parameterDic.allKeys;
                    for (NSInteger i = 0; i < array.count; i++) {
                        NSString *key = array[i];
                        if ([keyArray containsObject:key]) {
                            [target setValue:parameterDic[key] forKey:key];
                        }
                    }
                }
                [self.navigationController pushViewController:target animated:YES];
            }
        }
    }
}
- (void)pay:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSDictionary *parameter = dataDic[@"data"];
        NSString *type = dataDic[@"type"];
        __weak ZBToolWebViewController *weakSelf = self;
        if ([type isEqualToString:@"wx"]) {
            XHPayWxReq *req = [[XHPayWxReq alloc] init];
            req.openID = parameter[@"appid"];
            req.partnerId = parameter[@"partnerid"];
            req.prepayId = parameter[@"prepayid"];
            req.nonceStr = parameter[@"noncestr"];
            NSUInteger timStamp = [parameter[@"timestamp"] integerValue];
            req.timeStamp = timStamp;
            req.package = parameter[@"package"];
            req.sign = parameter[@"sign"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:wxpay];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){
                    weakSelf.callBack(@"1");
                } else {
                    weakSelf.callBack(@"0");
                }
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:wxpay];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }];
        } else if ([type isEqualToString:@"ali"]) {
            NSString *orderSign = dataDic[@"data"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:alipay];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[XHPayKit defaultManager] alipayOrder:orderSign fromScheme:@"com.Gunqiu.GQapp" completed:^(NSDictionary *resultDict) {
                NSInteger status = [resultDict[@"resultStatus"] integerValue];
                if(status == 9000){
                    weakSelf.callBack(@"1");
                } else {
                    weakSelf.callBack(@"0");
                }
            }];
        } else if ([type isEqualToString:@"apple"]) {
            [self appleBuyWithData:parameter];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"数据类型报错"];
    }
}
- (void)nav:(id)data {
    if ([data isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        BOOL nav_hidden = [dataDic[@"nav_hidden"] integerValue];
        [self.navigationController setNavigationBarHidden:nav_hidden animated:YES];
        [self configWebHeight];
        if (!nav_hidden) {
            self.navigationItem.title = dataDic[@"title"];
            NSArray *leftArray = dataDic[@"left"];
            if (leftArray.count > 0) {
                NSMutableArray *leftItemsArray = [NSMutableArray new];
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    NSDictionary *dic = leftArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    ZBNavImageView *imageV = [[ZBNavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [leftItemsArray addObject:item];
                }
                self.navigationItem.leftBarButtonItems = [leftItemsArray copy];
            }
            NSArray *rightArray = dataDic[@"right"];
            if (rightArray.count > 0) {
                NSMutableArray *rightItemsArray = [NSMutableArray new];
                rightArray = [[rightArray reverseObjectEnumerator] allObjects];
                for (NSInteger i = 0; i < rightArray.count; i ++) {
                    NSDictionary *dic = rightArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    ZBNavImageView *imageV = [[ZBNavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [rightItemsArray addObject:item];
                }
                self.navigationItem.rightBarButtonItems = rightItemsArray;
            }
        }
    }
}
- (void)pagetoolbar:(id)data {
    if ([data isKindOfClass:NSClassFromString(@"NSDictionary")]) {

        self.commentsDic = (NSDictionary *)data;
        if ([self.commentsDic[@"comment"][@"module"]  isEqualToString:@"community"]) {
            [self.view addSubview:self.replyBtn];
              self.wkWeb.height = self.wkWeb.height - self.replyBtn.height;
             self.replyBtn.top = self.wkWeb.bottom;
        } else {
            [self.view addSubview:self.commentsView];
            self.wkWeb.height = self.wkWeb.height - self.commentsView.height;
            self.commentsView.top = self.wkWeb.bottom;
            NSDictionary *commentDic = self.commentsDic[@"comment"];
            self.commentsView.newsID =  [NSString stringWithFormat:@"%@",commentDic[@"id"]];
            self.commentsView.module = [NSString stringWithFormat:@"%@",commentDic[@"module"]];
            [self.commentsView loadData];
        }
        
       
    }
}
#pragma mark - Private Method
- (NSString *)getJSONMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
- (void)pushToMatchDetail:(NSDictionary *)parameter {
    NSDictionary *v = parameter[@"v"];
    [self toFenxiWithMatchId:v[@"id"] toPageindex:[v[@"linkType"] integerValue] toItemIndex:[v[@"currentIndex"] integerValue]];
}
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                ZBLiveScoreModel *model = [ZBLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                model.neutrality = NO;
                ZBFenxiPageVC *fenxiVC = [[ZBFenxiPageVC alloc] init];
                fenxiVC.model = model;
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                fenxiVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            }
            _isToFenxi = NO;
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
        }];
    }else{
    }
}
- (void)createNullToastView:(NSString *)text imageName:(NSString *)imageName {
    if (!_toastView) {
        CGRect bounds = self.useWkWeb ? self.wkWeb.bounds : self.webView.bounds;
         _toastView = [[UIView alloc]initWithFrame:bounds];
        UIImageView *toastImageView = [UIImageView new];
        toastImageView.image = [UIImage imageNamed:imageName];
        toastImageView.contentMode = UIViewContentModeScaleToFill;
        toastImageView.userInteractionEnabled = YES;
        [_toastView addSubview:toastImageView];
        [toastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_toastView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadAction)];
        [toastImageView addGestureRecognizer:tap];
        if (self.useWkWeb) {
            [self.wkWeb addSubview:_toastView];
        } else {
            [self.webView addSubview:_toastView];
        }
    }
}
- (void)dissMissToastView {
    if (_toastView) {
        [_toastView removeFromSuperview];
        _toastView = nil;
    }
}
#pragma mark - Events

- (void)replyAction {
    if (![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBReplyViewController *control = [[ZBReplyViewController alloc]init];
    control.postId = self.commentsDic[@"comment"][@"id"];
    [self.navigationController pushViewController:control animated:true];
}

- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
}

- (void)reloadAction {
    [self loadData];
}
- (void)tableBarAction:(UITapGestureRecognizer *)tap {
    ZBNavImageView *imageView = (ZBNavImageView *)tap.view;
    if ([imageView.Parameter isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)imageView.Parameter;
        SEL selecter = NSSelectorFromString(dic[@"func"]);
        if ([self respondsToSelector:selecter]) {
            NSDictionary *data = dic[@"vars"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selecter withObject:data];
#pragma clang diagnostic pop
        }
    }
}
- (void)buyAction {
    if(![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"服务介绍";
    if (self.recordUrl) {
        if ([_recordUrl containsString:@"appH5/"]) {
            NSArray *array = [_recordUrl componentsSeparatedByString:@"appH5/"];
            NSString *htmlStr = [array lastObject];
            NSArray *modelArray = [htmlStr componentsSeparatedByString:@"."];
            NSString *modelStr = [modelArray firstObject];
            NSString *url= [NSString stringWithFormat:@"%@/appH5/%@-pay.html", APPDELEGATE.url_ip,modelStr];
            model.webUrl = url;
        }
    } else {
          model.webUrl = [NSString stringWithFormat:@"%@/appH5/%@", APPDELEGATE.url_ip,_model.modelType];
    }
    ZBToolWebViewController *webControl = [[ZBToolWebViewController alloc]init];
    webControl.model = model;
    [self.navigationController pushViewController:webControl animated:YES];
}
- (void)currentPage:(id)data {
    self.recordUrl = data;
}
- (void)payAction:(id)data {
    NSMutableArray *dataArray = [ArchiveFile getDataWithPath:Buy_Type_Path];
    if (!(dataArray.count > 0)) {
        [self appleBuyWithData:data];
        return;
    }
    NSString *matchID = data[@"scheduleId"];
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        NSDictionary *typeDic = dataArray[i];
        NSInteger type = [typeDic[@"type"] integerValue];
        NSString *text = typeDic[@"text"];
        NSString *icon = nil;
        switch (type) {
            case 0: {
                icon = @"appicon";
            }
                break;
            case 1: {
                icon = @"wxicon";
            }
                break;
            case 2: {
                icon = @"aliicon";
            }
                break;
            case 3: {
                icon = @"coupon";
            }
                break;
            default:
                break;
        }
        if (matchID && type == 3) {
            [array addObject:@{PayMentLeftIcon:icon, PayMentTitle:text, PayMentType:@(type), CouponCount:data[@"couponCount"]}];
        } else {
            [array addObject:@{PayMentLeftIcon:icon, PayMentTitle:text, PayMentType:@(type)}];
        }
    }
    if (!matchID) {
        [array removeLastObject];
    }
    __weak ZBToolWebViewController *weakSelf = self;
    [ZBSelectPayMentView showPaymentInfo:[NSString stringWithFormat:@"￥%@",PARAM_IS_NIL_ERROR(data[@"amount"])] options:array  animations:YES selectOption:^(payMentType type) {
        switch (type) {
            case payMentTypeApplePurchase: {
                [weakSelf appleBuyWithData:data];
            }
                break;
            case payMentTypeWx: {
                [weakSelf tencentBuyWithData:data];
            }
                break;
            case payMentTypeAli: {
                [weakSelf alibuyWithData:data];
            }
                break;
            case payMentTypeCoupon: {
                [weakSelf couponBuyWithData:data];
            }
                break;
            default:
                break;
        }
    }];
}


#pragma mark - Buy Type
- (void)tencentBuyWithData:(NSDictionary *)data {
    [ZBLodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [ZBHttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            NSDictionary *dataDic = resultDic[@"data"];
            XHPayWxReq *req = [[XHPayWxReq alloc] init];
            req.openID = dataDic[@"appid"];
            req.partnerId = dataDic[@"partnerid"];
            req.prepayId = dataDic[@"prepayid"];
            req.nonceStr = dataDic[@"noncestr"];
            NSUInteger timStamp = [dataDic[@"timestamp"] integerValue];
            req.timeStamp = timStamp;
            req.package = dataDic[@"package"];
            req.sign = dataDic[@"sign"];
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                }
            }];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}
- (void)alibuyWithData:(NSDictionary *)data {
    [ZBLodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [ZBHttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay_ali] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            NSString *orderSign = resultDic[@"data"];
            [[XHPayKit defaultManager] alipayOrder:orderSign fromScheme:@"com.Gunqiu.GQapp" completed:^(NSDictionary *resultDict) {
                NSInteger status = [resultDict[@"resultStatus"] integerValue];
                if(status == 9000){
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                }
            }];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}
- (void)appleBuyWithData:(NSDictionary *)data {
     MBProgressHUD *hud = [[MBProgressHUD alloc]init];
     hud.mode = MBProgressHUDModeIndeterminate;
     hud.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
     [self.view addSubview:hud];
     [hud show:YES];
    NSDictionary *dic = data;
    NSNumber *ordeId = dic[@"orderId"];
    NSString *productId = dic[@"productId"];
    NSInteger amount = [dic[@"amount"] integerValue];
    [[ZBAppleIAPService sharedInstance]purchase:@{@"product_id":PARAM_IS_NIL_ERROR(productId), @"orderID":ordeId, @"amount":@(amount)} resultBlock:^(NSString *message, NSError *error) {
        [hud hide:YES];
        if (error) {
            NSString *errMse = error.userInfo[@"NSLocalizedDescription"];
            [SVProgressHUD showErrorWithStatus:errMse];
        } else{
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)couponBuyWithData:(NSDictionary *)data {
    if (!([data[@"couponCount"] integerValue] > 0)) {
        [SVProgressHUD showErrorWithStatus:@"您暂时还未拥有优惠券"];
        return;
    }
    [ZBLodingAnimateView dissMissLoadingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [ZBHttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay_coupon] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"购买失败"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}
- (BOOL)containsClassName:(NSString *)className {
    NSArray *classArray = self.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (UIViewController *control in classArray) {
        if (control.class == targetClass) {
            return YES;
        } else {
            return false;
        }
    }
    return false;
}
- (id)indexWithClassName:(NSString *)className {
    NSArray *classArray = self.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (NSInteger i = 0; i < classArray.count; i++) {
        UIViewController *control = classArray[i];
        if (control.class == targetClass) {
            return control;
        }
    }
    return nil;
}
#pragma mark - Lazy Load

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        _webView.scrollView.showsHorizontalScrollIndicator = false;
        _webView.scrollView.showsVerticalScrollIndicator = false;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (WKWebView *)wkWeb {
    if (_wkWeb == nil) {
        _wkWeb = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _wkWeb.navigationDelegate = self;
        _wkWeb.UIDelegate = self;
        _wkWeb.scrollView.showsHorizontalScrollIndicator = false;
        _wkWeb.scrollView.showsVerticalScrollIndicator = false;
        _wkWeb.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        _wkWeb.backgroundColor = [UIColor whiteColor];
    }
    return _wkWeb;
}

- (ZBCommentsView *)commentsView {
    if (_commentsView == nil) {
        _commentsView = [[ZBCommentsView alloc]init];
        _commentsView.delegate = self;
    }
    return _commentsView;
}

- (UIButton *)replyBtn {
    if (_replyBtn == nil) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setBackgroundImage:[UIImage imageNamed:@"replyBtn"] forState:UIControlStateNormal];
        _replyBtn.frame = CGRectMake(0, Height - 46, Width, 46);
        [_replyBtn addTarget:self action:@selector(replyAction) forControlEvents:UIControlEventTouchUpInside];
        [_replyBtn addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
    }
    return _replyBtn;
}

- (GeneralFloatingView *)floatingView {
    if (_floatingView == nil) {
        _floatingView = [[GeneralFloatingView alloc]initWithImages:@[@"publish_btn", @"formReload"] scale:0.8 ignoreTabBar:true];
        _floatingView.delegate = self;
    }
    return _floatingView;
}

@end
