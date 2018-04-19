//
//  AppManger.h
//  newGQapp
//
//  Created by genglei on 2018/4/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManger : NSObject

+ (instancetype)shareInstance;

- (void)initialize;

- (UIWebView *)registerJSTool;

@end
