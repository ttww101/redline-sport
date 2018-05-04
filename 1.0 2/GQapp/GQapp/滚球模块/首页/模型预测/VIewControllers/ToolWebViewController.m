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
#import <UShareUI/UShareUI.h>
#import "CouponListViewController.h"
#import "LiveQuizWithDrawalViewController.h"
#import "XHPayKit.h"
#import "ArchiveFile.h"
#import "AppManger.h"


@interface ToolWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@property (nonatomic , copy) GQJSResponseCallback callBack;

@property (nonatomic , copy) NSString *recordUrl;

@end

@implementation ToolWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (_webView) {
//        _webView = nil;
//        [_webView removeFromSuperview];
//    }
    [self configUI];
    [self loadBradgeHandler];
    [self loadData];
}

- (void)loadBradgeHandler {
    __weak ToolWebViewController *weakSelf = self;
    WebViewJavascriptBridge *bridge = [[AppManger shareInstance]registerJSTool:self.webView hannle:^(id data, GQJSResponseCallback responseCallback) {
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
    
    [bridge setWebViewDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
        [self.webView loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
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

    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    
    if (_model.showBuyBtn) {
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyBtn setTitle:@"开通服务" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.frame = CGRectMake(0, 0, 60, 44);
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buyBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
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

#pragma mark - JSHandle

- (void)back:(id)parameter {
    if ([parameter integerValue] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
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
        if ([type isEqualToString:@"wx"]) {
            XHPayWxReq *req = [[XHPayWxReq alloc] init];
            req.openID = parameter[@"appid"];
            req.partnerId = parameter[@"partnerid"];
            req.prepayId = parameter[@"prepayid"];
            req.nonceStr = parameter[@"noncestr"];
            NSUInteger timStamp = [parameter[@"timestamp"] integerValue];
            req.timeStamp = timStamp;//时间戳，防重发
            req.package = parameter[@"package"];
            req.sign = parameter[@"sign"];//签名
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){//支付成功
                    self.callBack(@"1");
                } else {
                    self.callBack(@"0");
                }
            }];
        } else if ([type isEqualToString:@"ali"]) {
            NSString *orderSign = dataDic[@"data"];
            [[XHPayKit defaultManager] alipayOrder:orderSign fromScheme:@"com.Gunqiu.GQapp" completed:^(NSDictionary *resultDict) {
                NSInteger status = [resultDict[@"resultStatus"] integerValue];
                if(status == 9000){
                    self.callBack(@"1");
                } else {
                    self.callBack(@"0");
                }
            }];
        } else if ([type isEqualToString:@"apple"]) {
            [self appleBuyWithData:parameter];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"数据类型报错"];
    }
}

#pragma mark - Events

- (void)buyAction {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"服务介绍";
    if (self.recordUrl) {
        model.webUrl = self.recordUrl;
    } else {
          model.webUrl = [NSString stringWithFormat:@"%@:81/appH5/spfmode-pay.html", APPDELEGATE.url_jsonHeader];
    }
    
    ToolWebViewController *webControl = [[ToolWebViewController alloc]init];
    webControl.model = model;
    [self.navigationController pushViewController:webControl animated:YES];
}



- (void)currentPageUrl:(id)data {
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
    
    __weak ToolWebViewController *weakSelf = self;
    [SelectPayMentView showPaymentInfo:[NSString stringWithFormat:@"￥%@",PARAM_IS_NIL_ERROR(data[@"amount"])] options:array  animations:YES selectOption:^(payMentType type) {
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
    [LodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            NSDictionary *dataDic = resultDic[@"data"];
            XHPayWxReq *req = [[XHPayWxReq alloc] init];
            req.openID = dataDic[@"appid"];
            req.partnerId = dataDic[@"partnerid"];
            req.prepayId = dataDic[@"prepayid"];
            req.nonceStr = dataDic[@"noncestr"];
            NSUInteger timStamp = [dataDic[@"timestamp"] integerValue];
            req.timeStamp = timStamp;//时间戳，防重发
            req.package = dataDic[@"package"];
            req.sign = dataDic[@"sign"];//签名
            
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){//支付成功
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                }
            }];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

- (void)alibuyWithData:(NSDictionary *)data {
    [LodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay_ali] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
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
        [LodingAnimateView dissMissLoadingView];
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
    NSInteger amount = [Methods amountWithProductId:productId];
    amount = amount * 100;
    
    [[AppleIAPService sharedInstance]purchase:@{@"product_id":productId, @"orderID":ordeId, @"amount":@(amount)} resultBlock:^(NSString *message, NSError *error) {
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
    [LodingAnimateView dissMissLoadingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay_coupon] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"购买失败"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
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

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _webView;
}

@end
