//
//  BaseWebViewController.h
//  newGQapp
//
//  Created by genglei on 2018/4/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebModel.h"

@interface BaseWebViewController : UIViewController

@property (nonatomic , strong) WebModel *model;

@property (nonatomic, copy) NSString *webTitle;

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@end
