//
//  WithdrawalModel.h
//  newGQapp
//
//  Created by genglei on 2018/4/14.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawalModel : NSObject

/**
 时间戳 北京时间
 */
@property (nonatomic , assign) NSUInteger created;

@property (nonatomic , copy) NSString *amount;

@property (nonatomic , copy) NSString *item_name;

@end

@interface WithdrawaListModel : NSObject

/**
 闯关成功次数
 */
@property (nonatomic , copy) NSString *total_winner_count;

/**
 提现说明
 */
@property (nonatomic , copy) NSString *note;

/**
 当前可分成金额 单位：分
 */
@property (nonatomic , copy) NSString *total_reward_amount;

/**
 是否允许提现
 */
@property (nonatomic , assign) BOOL is_allow;

@property (nonatomic , strong) NSMutableArray *items;

@end


