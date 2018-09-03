//
//  ZBJSModel.h
//  newGQapp
//
//  Created by genglei on 2018/4/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const WithDrawal; // 提现

UIKIT_EXTERN NSString *const Coupon; // 提现



@interface ZBJSModel : NSObject

@property (nonatomic , copy) NSString *methdName;

@property (nonatomic, strong) id parameterData;

@end
