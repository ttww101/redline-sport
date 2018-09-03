//
//  RecommendedWebView.h
//  newGQapp
//
//  Created by genglei on 2018/5/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebModel.h"

@interface RecommendedWebView : UIWebView

@property (nonatomic , strong) WebModel *model;

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic, assign) BOOL cellCanScroll;

- (void)reloadData;

- (void)cancleLoadData;

@end
