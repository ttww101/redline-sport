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

#pragma mark - Events

- (void)buyAction {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"服务介绍";
    //            model.webUrl = [NSString stringWithFormat:@"%@/mx/spfmode-pay.html", APPDELEGATE.url_jsonHeader];
    model.webUrl = [NSString stringWithFormat:@"%@:81/ios/spfmode-pay.html", APPDELEGATE.url_jsonHeader];
    ToolWebViewController *webControl = [[ToolWebViewController alloc]init];
    webControl.model = model;
    [self.navigationController pushViewController:webControl animated:YES];
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
            [array addObject:@{PayMentLeftIcon:icon, PayMentTitle:text, PayMentType:@(type)}];
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
     
     NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
     [parameter setObject:data[@"type"] forKey:@"modelType"];
     [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
     [parameter setObject:@"IOS" forKey:@"resource"];
     [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
     
     [[DCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_purchase] ArrayFile:nil Start:^(id requestOrignal) {
     [LodingAnimateView showLodingView];
     } End:^(id responseOrignal) {
     
     } Success:^(id responseResult, id responseOrignal) {
     [LodingAnimateView dissMissLoadingView];
     
     NSDictionary *dic = (NSDictionary *)responseOrignal;
     NSDictionary *dataDic = dic[@"data"];
     NSString *ordeId = dataDic[@"orderId"];
     NSString *productId = data[@"productID"];
     NSInteger amount = [Methods amountWithProductId:productId];
     amount = amount * 100;
     NSString *statusCode = dic[@"code"];
     
         if ([statusCode isEqualToString:@"200"]) {
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
         } else {
             [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
             [hud hide:YES];
         }
     } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
         [hud hide:YES];
         [LodingAnimateView dissMissLoadingView];
         [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
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
