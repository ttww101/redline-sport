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
    
    if ([_model.title isEqualToString:@"直播答题"]) {
        NSString *jsonToken = [self getJSONMessage:@{@"token":PARAM_IS_NIL_ERROR(token)}];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getToken", @"val":PARAM_IS_NIL_ERROR(jsonToken)}];
        
        [self.bridge registerHandler:@"toLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            //显示分享面板
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 根据获取的platformType确定所选平台进行下一步操作
            }];
            return;
        }];
        
        [self.bridge registerHandler:@"getToken" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {

            }];
            responseCallback(jsonParameter);
        }];
        
        // 1 登陆 2分享 3不满10元提现 4满10元提现 5我的优惠券列表 6活动规则
        [self.bridge registerHandler:@"open" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"openh5" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"txtCopy" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            UIPasteboard *paste = [UIPasteboard generalPasteboard];
            paste.string = data;
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"getState" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        [self.bridge registerHandler:@"back" handler:^(id data, WVJBResponseCallback responseCallback) {
            [self.navigationController popViewControllerAnimated:YES];
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
        
        // 内购方法
        [self.bridge registerHandler:_model.registerActionName handler:^(id data, WVJBResponseCallback responseCallback) {
        
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
    webModel.webUrl = [NSString stringWithFormat:@"%@/mx/%@", APPDELEGATE.url_jsonHeader ,url];
//    webModel.webUrl = [NSString stringWithFormat:@"%@:81/ios/%@", APPDELEGATE.url_jsonHeader ,url];
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
    }
    return _webView;
}

@end
