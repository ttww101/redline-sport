//
//  ZBWithdrawalModel.m
//  newGQapp
//
//  Created by genglei on 2018/4/14.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBWithdrawalModel.h"

@implementation ZBWithdrawalModel

@end

@implementation WithdrawaListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : NSClassFromString(@"ZBWithdrawalModel") };
}

@end

