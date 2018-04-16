//
//  ToolWebViewController.h
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebModel.h"
#import "SelectPayMentView.h"

@interface ToolWebViewController : UIViewController

@property (nonatomic, copy) NSString *webTitle;

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic , copy) NSDictionary *parameterDic;

@property (nonatomic , strong) WebModel *model;


@end
