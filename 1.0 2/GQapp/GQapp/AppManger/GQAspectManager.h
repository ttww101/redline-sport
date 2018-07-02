//
//  GQAspectManager.h
//  newGQapp
//
//  Created by genglei on 2018/7/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Aspects/Aspects.h>


@interface GQAspectManager : NSObject

+ (void)GQ_trackAspectHooks;

/**
 用户页面访问路径
 */
+ (void)GQ_SavePageDic;

+ (NSMutableDictionary *)GQ_PathForPageDic;

@end
