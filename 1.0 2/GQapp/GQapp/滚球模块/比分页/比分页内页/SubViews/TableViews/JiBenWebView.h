//
//  JiBenWebView.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/23.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveScoreModel.h"
#import <WebKit/WebKit.h>
@interface JiBenWebView : UIWebView
@property (nonatomic, strong) LiveScoreModel *model;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
