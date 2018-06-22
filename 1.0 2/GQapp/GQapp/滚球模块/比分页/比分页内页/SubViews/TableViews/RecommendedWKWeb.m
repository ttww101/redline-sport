//
//  RecommendedWKWeb.m
//  newGQapp
//
//  Created by genglei on 2018/6/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "RecommendedWKWeb.h"
#import "WebViewJavascriptBridge.h"
#import "AppManger.h"
#import <YYModel/YYModel.h>
#import "ToolWebViewController.h"
#import "ArchiveFile.h"
#import "WebviewProgressLine.h"
#import <WebKit/WebKit.h>

@interface RecommendedWKWeb () <UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic , copy) GQJSResponseCallback callBack;

@property (nonatomic , strong) WebviewProgressLine *progressLine;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@end

@implementation RecommendedWKWeb

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorTableViewBackgroundColor;
        [self loadBradgeHandler];
    }
    return self;
}

#pragma mark - Open Method

- (void)setModel:(WebModel *)model {
    _model = model;
    [self loadData];
    
}

#pragma mark - Load Data

- (void)loadBradgeHandler {
    __weak RecommendedWKWeb *weakSelf = self;
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


@end
