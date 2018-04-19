//
//  AppManger.m
//  newGQapp
//
//  Created by genglei on 2018/4/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AppManger.h"
#import "WebViewJavascriptBridge.h"


@interface AppManger ()

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge *bridge;



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

- (UIWebView *)registerJSTool {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    [self initJavaScriptObservers];
    
    return _webView;
}

- (void)initJavaScriptObservers {
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    NSString *token = [Methods getTokenModel].token;
    NSString *jsonToken = [self getJSONMessage:@{@"token":PARAM_IS_NIL_ERROR(token)}];
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getToken", @"val":PARAM_IS_NIL_ERROR(jsonToken)}];
    
    // 注册token
    [self.bridge registerHandler:@"getToken" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            
        }];
        responseCallback(jsonParameter);
    }];
    
    // 注册设备信息
    [self.bridge registerHandler:@"info" handler:^(id data, WVJBResponseCallback responseCallback) {
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
                                  @"deviceType":[Methods iphoneType]
                                  };
        
        NSString *jsonInfo = [self getJSONMessage:infoDic];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"info", @"val":jsonInfo}];
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            
        }];
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
