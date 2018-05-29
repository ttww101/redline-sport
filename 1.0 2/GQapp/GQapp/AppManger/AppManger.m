//
//  AppManger.m
//  newGQapp
//
//  Created by genglei on 2018/4/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AppManger.h"
#import "WebModel.h"
#import "ToolWebViewController.h"
#import "DCTabBarController.h"
#import <YYModel/YYModel.h>
#import "ArchiveFile.h"


@interface AppManger ()

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge *bridge;

@property (nonatomic , copy) GQJSHandler gqHandler;

@end

@implementation AppManger

+ (instancetype)shareInstance {
    static AppManger *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc]init];
    });
    return manger;
}

- (void)initialize {
    
}

- (WebViewJavascriptBridge *)registerJSTool:(UIWebView *)webView hannle:(GQJSHandler)jsHandle {
    if (webView) {
        self.webView = webView;
    }
    if (jsHandle) {
        self.gqHandler = jsHandle;
    }
    [self initJavaScriptObservers];
    return self.bridge;
}

- (void)initJavaScriptObservers {
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    NSString *token = [Methods getTokenModel].token;
    NSString *jsonToken = [self getJSONMessage:@{@"token":PARAM_IS_NIL_ERROR(token)}];
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getToken", @"val":PARAM_IS_NIL_ERROR(jsonToken)}];
    
    // 获取当前页面链接
    [self.bridge registerHandler:@"currentPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"currentPage:",
                                                            @"parameterData":data}];
        self.gqHandler(model, ^(id responseData) {
        });
    }];
    
    // 注册token
    [self.bridge registerHandler:@"getToken" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            
        }];
        responseCallback(jsonParameter);
    }];
    
    // 注册设备信息
    [self.bridge registerHandler:@"info" handler:^(id data, WVJBResponseCallback responseCallback) {
        UserModel *model =[Methods getUserModel];
        NSMutableArray *dataArray = [ArchiveFile getDataWithPath:Buy_Type_Path];
        NSInteger weatherShowThirdPay = 0;
        if (dataArray.count > 0) {
            weatherShowThirdPay = 1;
        }
        NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        NSString *sysVersion = [UIDevice currentDevice].systemVersion;
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSDictionary *infoDic = @{
                                  @"platform":@"1",
                                  @"visit":@(1),
                                  @"version":version,
                                  @"resource":@"iOS",
                                  @"sysVersion":sysVersion,
                                  @"uuid":idfv,
                                  @"deviceType":[Methods iphoneType],
                                  @"userId": @(model.idId),
                                  @"thirdPay":@(weatherShowThirdPay)
                                  };
        
        NSString *jsonInfo = [self getJSONMessage:infoDic];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"info", @"val":jsonInfo}];
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            
        }];
    }];
    
    //  H5跳转
    [self.bridge registerHandler:@"openH5" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        WebModel *webModel = [[WebModel alloc]init];
        webModel.title = dic[@"title"];
        webModel.webUrl =  dic[@"url"];
        webModel.parameter = dic[@"nav"];
        webModel.hideNavigationBar = [dic[@"nav_hidden"] integerValue];
        ToolWebViewController *control = [[ToolWebViewController alloc]init];
        control.model = webModel;
        [APPDELEGATE.customTabbar pushToViewController:control animated:YES];
        return ;
    }];
    
    // 复制事件
    [self.bridge registerHandler:@"txtCopy" handler:^(id data, WVJBResponseCallback responseCallback) {
        UIPasteboard *paste = [UIPasteboard generalPasteboard];
        paste.string = data;
        [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    }];
    
    // 获取状态
    [self.bridge registerHandler:@"getState" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"11323");
        responseCallback(@"Response from testObjcCallback");
    }];
    
    //  0  原生可以退出    1  原生不可退出
    [self.bridge registerHandler:@"back" handler:^(id data, WVJBResponseCallback responseCallback) {
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"back:",
                                                            @"parameterData":data}];
        self.gqHandler(model, ^(id responseData) {
            NSString *jsonUrlPath = [self getJSONMessage:@{@"imagePath":responseData}];
            NSString *jsonParameter = [self getJSONMessage:@{@"id":@"back", @"val":jsonUrlPath}];
            [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                
            }];
        });
        responseCallback(@"Response from testObjcCallback");
    }];
    
    // 输出
    [self.bridge registerHandler:@"dialog" handler:^(id data, WVJBResponseCallback responseCallback) {
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"dialog:",
                                                            @"parameterData":data}];
        self.gqHandler(model, ^(id responseData) {
            NSString *jsonUrlPath = [self getJSONMessage:@{@"imagePath":responseData}];
            NSString *jsonParameter = [self getJSONMessage:@{@"id":@"back", @"val":jsonUrlPath}];
            [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                
            }];
        });
        
    }];
    
    // 弹出框
    [self.bridge registerHandler:@"toast" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        [SVProgressHUD showSuccessWithStatus:dic[@"text"]];
        [SVProgressHUD dismissWithDelay:[dic[@"time"] integerValue] / 1000];
    }];
    
    // 读取本地资源
    [self.bridge registerHandler:@"getResource" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"00" ofType:@"png"];
        NSURL *urlPath = [NSURL fileURLWithPath:path];
        NSString *jsonUrlPath = [self getJSONMessage:@{@"imagePath":urlPath.absoluteString}];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getResource", @"val":jsonUrlPath}];
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        }];
    }];
    
    // 1 登陆 3不满10元提现 4满10元提现 5我的优惠券列表 调用原生的方式
    [self.bridge registerHandler:@"open" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSInteger type = [data integerValue];
        NSString *className = nil;
        if (type == 1) {
            if (![Methods login]) {
                [Methods toLogin];
                return;
            }
        } else if (type == 2) {
            
        } else if (type == 3) {
            
        } else if (type == 4) {
            className = @"LiveQuizWithDrawalViewController";
        } else if (type == 5) {
            className = @"CouponListViewController";
        }
        
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"open:",
                                                            @"parameterData":className}];
        self.gqHandler(model, ^(id responseData) {
            
        });
        
        responseCallback(@"Response from testObjcCallback");
    }];
    
    // 分享事件
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
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[Methods help_getCurrentVC] completion:^(id data, NSError *error) {
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
    
    [self.bridge registerHandler:@"toLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (![Methods login]) {
            [Methods toLogin];
            return;
        }
        responseCallback(@"Response from testObjcCallback");
    }];
    
    
    [self.bridge registerHandler:@"payAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"payAction:",
                                                            @"parameterData":dic}];
        self.gqHandler(model, ^(id responseData) {
        });
    }];
    
    [self.bridge registerHandler:@"openNative" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"openNative:",
                                                            @"parameterData":dic}];
        self.gqHandler(model, ^(id responseData) {
            
        });
    }];
    

    [self.bridge registerHandler:@"nav" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                           @"methdName":@"nav:",
                                                           @"parameterData":dic}];
        self.gqHandler(model, ^(id responseData) {
            
        });
    }];
    
    [self.bridge registerHandler:@"pay" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        JSModel *model =  [JSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"pay:",
                                                            @"parameterData":dic}];
        self.gqHandler(model, ^(id responseData) {
            if ([responseData integerValue] == 1) {
                NSString *jsonParameter = [self getJSONMessage:@{@"id":@"paySuccess", @"val":@(1)}];
                [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                    
                }];
            } else {
                NSString *jsonParameter = [self getJSONMessage:@{@"id":@"payFailed", @"val":@(0)}];
                [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                    
                }];
            }
        });
    }];
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

@end
