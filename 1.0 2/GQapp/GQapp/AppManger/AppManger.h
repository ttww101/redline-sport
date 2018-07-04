//
//  AppManger.h
//  newGQapp
//
//  Created by genglei on 2018/4/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSModel.h"
#import "WebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>

typedef void (^GQJSResponseCallback)(id responseData);
typedef void (^GQJSHandler)(id data, GQJSResponseCallback responseCallback);

@interface AppManger : NSObject

+ (instancetype)shareInstance;

- (void)initialize;

- (WebViewJavascriptBridge *)registerJSTool:(UIWebView *)webView hannle:(GQJSHandler)jsHandle;

- (WebViewJavascriptBridge *)WK_RegisterJSTool:(WKWebView *)webView hannle:(GQJSHandler)jsHandle;




@end
