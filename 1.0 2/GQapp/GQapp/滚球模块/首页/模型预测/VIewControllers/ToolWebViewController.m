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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
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
    
    UIButton *refrshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refrshBtn.frame = CGRectMake(0, 0, 40, 40);
    [refrshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refrshBtn addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:refrshBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
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
            req.openID = dataDic[@"appid"];//微信开放平台审核通过的应用APPID
            req.partnerId = dataDic[@"partnerid"];//商户号
            req.prepayId = dataDic[@"prepayid"];//交易会话ID
            req.nonceStr = dataDic[@"noncestr"];//随机串，防重发
            NSUInteger timStamp = [dataDic[@"timestamp"] integerValue];
            req.timeStamp = timStamp;//时间戳，防重发
            req.package = dataDic[@"package"];// 扩展字段,暂填写固定值Sign=WXPay
            req.sign = dataDic[@"sign"];//签名
            
            //传入订单模型,拉起微信支付
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSLog(@"支付结果:\n%@",resultDict);
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){//支付成功
                }
            }];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

- (void)alibuyWithData:(NSDictionary *)data {
    
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
    
}

#pragma mark - Private

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
    
    if ([_model.title isEqualToString:@"直播答题"]) {
        NSString *jsonToken = [self getJSONMessage:@{@"token":PARAM_IS_NIL_ERROR(token)}];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getToken", @"val":PARAM_IS_NIL_ERROR(jsonToken)}];
        
        [self.bridge registerHandler:@"toLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
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
                
                
                //创建分享消息对象
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                //创建网页内容对象
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:des thumImage:picurl];
                //设置网页地址
                shareObject.webpageUrl = linkurl;
                //分享消息对象设置分享内容对象
                messageObject.shareObject = shareObject;
                //调用分享接口
                [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
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
        
            return;
            
        }];
        
      
        [self.bridge registerHandler:@"getToken" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {

            }];
            responseCallback(jsonParameter);
        }];
        
        // 1 登陆 3不满10元提现 4满10元提现 5我的优惠券列表
        [self.bridge registerHandler:@"open" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSInteger type = [data integerValue];
            if (type == 1) {
                if (![Methods login]) {
                    [Methods toLogin];
                    return;
                }
            } else if (type == 3) {
                
            } else if (type == 4) {
                LiveQuizWithDrawalViewController *control = [[LiveQuizWithDrawalViewController alloc]init];
                [self.navigationController pushViewController:control animated:YES];
            } else if (type == 5) {
                CouponListViewController *control = [[CouponListViewController alloc]init];
                [self.navigationController pushViewController:control animated:YES];
            }
            responseCallback(@"Response from testObjcCallback");
        }];
        
         //   6活动规则
        [self.bridge registerHandler:@"openH5" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            WebModel *webModel = [[WebModel alloc]init];
            webModel.title = dic[@"title"];
            webModel.webUrl =  dic[@"url"];
            webModel.hideNavigationBar = false;
            ToolWebViewController *control = [[ToolWebViewController alloc]init];
            control.model = webModel;
            [self.navigationController pushViewController:control animated:YES];
            return ;
        }];
        
        [self.bridge registerHandler:@"txtCopy" handler:^(id data, WVJBResponseCallback responseCallback) {
            UIPasteboard *paste = [UIPasteboard generalPasteboard];
            paste.string = data;
            [SVProgressHUD showSuccessWithStatus:@"粘贴成功"];
        }];
        
        [self.bridge registerHandler:@"getState" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"back" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self.navigationController popViewControllerAnimated:YES];
            responseCallback(@"Response from testObjcCallback");
        }];
    }
    

    if (_model.parameter) {
        [self.bridge callHandler:_model.callHandleActionName data:_model.parameter responseCallback:^(id responseData) {
        
        }];
        
        // 内购方法   type 1胜平负 2亚盘 3大小球   serviceType 1单场 2 188元7天
        [self.bridge registerHandler:_model.registerActionName handler:^(id data, WVJBResponseCallback responseCallback) {
            
            NSArray *array = @[
                               @{PayMentLeftIcon:@"appicon", PayMentTitle:@"Apple Pay", PayMentType:@(payMentTypeApplePurchase)},
                               @{PayMentLeftIcon:@"wxicon", PayMentTitle:@"微信支付", PayMentType:@(payMentTypeWx)},
                               @{PayMentLeftIcon:@"aliicon", PayMentTitle:@"支付宝支付", PayMentType:@(payMentTypeAli)},
                               @{PayMentLeftIcon:@"coupon", PayMentTitle:@"优惠券支付", PayMentType:@(payMentTypeCoupon)}
                               ];
            
            __weak ToolWebViewController *weakSelf = self;
            [SelectPayMentView showPaymentInfo:@"￥ 123" options:array  animations:YES selectOption:^(payMentType type) {
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
        }];
        
        [self.bridge registerHandler:@"toPage" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self responseRegisterAction:data];
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"toProtocol" handler:^(id data, WVJBResponseCallback responseCallback) {
            WebModel *webModel = [[WebModel alloc]init];
            webModel.title = @"滚球增值服务协议";
            webModel.webUrl = data[@"url"];
            ToolWebViewController *control = [[ToolWebViewController alloc]init];
            control.model = webModel;
            [self.navigationController pushViewController:control animated:YES];
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
//    webModel.webUrl = [NSString stringWithFormat:@"%@/mx/%@", APPDELEGATE.url_jsonHeader ,url];
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

- (void)refreshAction:(UIButton *)sender {
    [self loadBradge];
    [self loadData];
}

- (NSString *)getJSONMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
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
