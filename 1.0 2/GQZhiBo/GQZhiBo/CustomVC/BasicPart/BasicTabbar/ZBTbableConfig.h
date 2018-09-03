//
//  ZBTbableConfig.h
//  newGQapp
//
//  Created by genglei on 2018/4/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBDCTabBarController.h"

@interface ZBTbableConfig : NSObject

/**
 根控制器
 */
@property (nonatomic, readonly, strong) ZBDCTabBarController *tableBarController;

/**
 选择加载页面
 */
@property (nonatomic, copy) NSString *currentPage;

@end
