//
//  ZBRecommendedWKWeb.h
//  newGQapp
//
//  Created by genglei on 2018/6/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "ZBWebModel.h"

@interface ZBRecommendedWKWeb : WKWebView

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic , strong) ZBWebModel *model;

@property (nonatomic, assign) BOOL cellCanScroll;

- (void)reloadData;

@end
