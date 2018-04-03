//
//  WebModel.h
//  newGQapp
//
//  Created by genglei on 2018/4/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebModel : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString* title;

/**
 类别
 */
@property (nonatomic, copy) NSString* category;

/**
 url
 */
@property (nonatomic, copy) NSString* webUrl;

/**
 htmlUrl
 */
@property (nonatomic, copy) NSString* htmlUrl;

/**
 附带参数
 */
@property (nonatomic, strong) id parameter;

/**
 注册原生调用JS 事件
 */
@property (nonatomic , copy) NSString *registerActionName;

/**
 注册JS调用原生 事件
 */
@property (nonatomic , copy) NSString *callHandleActionName;

@end
