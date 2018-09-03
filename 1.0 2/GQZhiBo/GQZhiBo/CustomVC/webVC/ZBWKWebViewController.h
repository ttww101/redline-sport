//
//  ZBWKWebViewController.h
//  CCAV5
//
//  Created by WQ on 2017/3/23.
//  Copyright © 2017年 Gunqiu. All rights reserved.
//

#import "ZBBasicViewController.h"
@interface ZBWKWebViewController : ZBBasicViewController
@property (nonatomic,copy)NSString *strurl;
@property (nonatomic,copy)NSString *strtitle;
@property (nonatomic,assign) BOOL showRefreshBtn;
@end
