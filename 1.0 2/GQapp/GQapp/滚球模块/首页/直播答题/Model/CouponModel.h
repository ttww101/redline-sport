//
//  CouponModel.h
//  newGQapp
//
//  Created by genglei on 2018/4/13.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property (nonatomic , copy) NSString *beginTime;

@property (nonatomic , copy) NSString *endTime;

@property (nonatomic , copy) NSString *couponID;

@property (nonatomic , copy) NSString *price;

@property (nonatomic , copy) NSString *status;

@end

@interface CouponListModel : NSObject

@property (nonatomic , strong) NSMutableArray<CouponModel *> *data;


@end

