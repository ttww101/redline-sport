//
//  GQWebView.h
//  newGQapp
//
//  Created by genglei on 2018/6/6.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQWebViewDelegate <NSObject>

@optional

- (void)webClose:(id)data;

@end

#import "WebModel.h"


@interface GQWebView : UIWebView

@property (nonatomic, weak) id <GQWebViewDelegate> webDelegate;

@property (nonatomic , strong) WebModel *model;

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic, assign) BOOL cellCanScroll;

- (void)reloadData;

@end
