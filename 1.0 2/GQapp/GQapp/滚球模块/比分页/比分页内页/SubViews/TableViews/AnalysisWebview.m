//
//  AnalysisWebview.m
//  newGQapp
//
//  Created by genglei on 2018/6/1.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AnalysisWebview.h"

@implementation AnalysisWebview


- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [LodingAnimateView showLodingView];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [LodingAnimateView dissMissLoadingView];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
//    [LodingAnimateView dissMissLoadingView];

}

@end
