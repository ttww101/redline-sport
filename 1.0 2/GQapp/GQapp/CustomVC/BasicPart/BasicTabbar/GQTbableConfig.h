//
//  GQTbableConfig.h
//  newGQapp
//
//  Created by genglei on 2018/4/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCTabBarController.h"

@interface GQTbableConfig : NSObject

/**
 根控制器
 */
@property (nonatomic, readonly, strong) DCTabBarController *tableBarController;

/**
 选择加载页面
 */
@property (nonatomic, copy) NSString *currentPage;

@end
