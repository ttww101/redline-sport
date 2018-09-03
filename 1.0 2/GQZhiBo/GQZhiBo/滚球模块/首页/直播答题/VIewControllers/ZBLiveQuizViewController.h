//
//  ZBLiveQuizViewController.h
//  newGQapp
//
//  Created by genglei on 2018/4/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBWebModel.h"

@interface ZBLiveQuizViewController : UIViewController

@property (nonatomic, copy) NSString *webTitle;

@property (nonatomic, copy) NSString *html5Url;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic , copy) NSDictionary *parameterDic;

@property (nonatomic , strong) ZBWebModel *model;

@end
