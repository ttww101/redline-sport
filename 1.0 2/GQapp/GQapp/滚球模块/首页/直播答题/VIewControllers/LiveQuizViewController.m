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

@interface LiveQuizViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@end

@implementation LiveQuizViewController

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


#pragma mark - Private

- (void)loadBradge {
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    NSString *token = [Methods getTokenModel].token;
    
   
    /**/
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
            [SVProgressHUD showSuccessWithStatus:@"复制成功"];
        }];
        
        [self.bridge registerHandler:@"getState" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"11323");
            responseCallback(@"Response from testObjcCallback");
        }];
        
        //  0  原生可以退出    1  原生不可退出
        [self.bridge registerHandler:@"back" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            if ([dic[@"type"] integerValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {

                [LiveQuizAlertView showPaymentInfo:dic[@"text"] animations:YES selectOption:^(id selectAction) {
                    if (selectAction) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }
            responseCallback(@"Response from testObjcCallback");
        }];
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

#pragma mark - PrivateMethod

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

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        _webView.scrollView.scrollEnabled = false;
//        _webView.scrollView.bounces = false;
//        [_webView setMediaPlaybackRequiresUserAction:NO];
//        [_webView setMediaPlaybackAllowsAirPlay:false];
    }
    return _webView;
}

@end
