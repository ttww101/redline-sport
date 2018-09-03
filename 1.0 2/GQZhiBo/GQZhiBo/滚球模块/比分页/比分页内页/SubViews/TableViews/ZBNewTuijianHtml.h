//
//  ZBNewTuijianHtml.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"
#import <WebKit/WebKit.h>

@interface ZBNewTuijianHtml : UIWebView
@property (nonatomic, strong) ZBLiveScoreModel *model;
@property (nonatomic, assign) NSInteger segIndex;
@property (nonatomic, assign) BOOL cellCanScroll;

@end
