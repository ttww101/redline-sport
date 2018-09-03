//
//  ZBRecommendedWebView.h
//  newGQapp
//
//  Created by genglei on 2018/5/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBWebModel.h"

@interface ZBRecommendedWebView : UIWebView

@property (nonatomic , strong) ZBWebModel *model;

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic, assign) BOOL cellCanScroll;

- (void)reloadData;

- (void)cancleLoadData;

@end
