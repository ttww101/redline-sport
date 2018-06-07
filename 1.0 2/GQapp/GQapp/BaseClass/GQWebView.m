//
//  GQWebView.m
//  newGQapp
//
//  Created by genglei on 2018/6/6.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "GQWebView.h"
#import "WebViewJavascriptBridge.h"
#import "AppManger.h"
#import <YYModel/YYModel.h>
#import "ToolWebViewController.h"
#import "ArchiveFile.h"

@interface GQWebView () <UIWebViewDelegate>

@property (nonatomic , copy) GQJSResponseCallback callBack;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;


@end

@implementation GQWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorTableViewBackgroundColor;
        [self loadBradgeHandler];
       
    }
    return self;
}

- (void)setModel:(WebModel *)model {
    _model = model;
     [self loadData];
}

- (void)reloadData {
    [self loadData];
}

- (void)loadBradgeHandler {
    __weak GQWebView *weakSelf = self;
    AppManger *manger = [[AppManger alloc]init];
    WebViewJavascriptBridge* bridge = [manger registerJSTool:self hannle:^(id data, GQJSResponseCallback responseCallback) {
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
    self.bridge = bridge;
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
        [self loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}

#pragma mark - JS Handle

- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
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
            [[Methods help_getCurrentVC].navigationController pushViewController:target animated:YES];
        }
    }
}

- (void)closeWin:(id)data {
    
}

#pragma mark - UIWebViewDelegate


- (void)webViewDidStartLoad:(UIWebView *)webView {
    //    [LodingAnimateView showLodingView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    [LodingAnimateView dissMissLoadingView];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [SVProgressHUD showErrorWithStatus:@"加载失败"];
//        [LodingAnimateView dissMissLoadingView];
    
}

#pragma mark - Open Method

- (void)shake_start {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shake_start", @"val":@""}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        
    }];
}

- (void)shake_end {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shake_end", @"val":@""}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        
    }];
}

#pragma mark - Private Method

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
