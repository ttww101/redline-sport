//
//  ZBDependetNetMethods.h
//  GQapp
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLSingleton.h"

@interface ZBDependetNetMethods : NSObject

INTERFACE_SINGLETON(ZBDependetNetMethods)
//本地图片转换线上图片
- (void)uploadImageWithImageArr:(NSArray *)arrImage completion:(void(^)(BOOL finished,NSArray*arrUrl)) completion;
//获取本地登录者用户信息

- (void)loadUserInfocompletion:(void(^)(ZBUserModel *userback))userBack errorMessage:(void(^)(NSString * msg)) errormsg;
//同赔指数
- (void)requestSameOdd_indexStart:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure;

//同赔指数详情
- (void)requestSameOdd_detailWithscheduleId:(NSString *)scheduleId
                               WithsclassId:(NSString *)sclassId
                                      Start:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure;

//爆冷指数
- (void)requeSurprisestatisWithType:(NSString *)type
                                    Start:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure;
//爆冷详情
- (void)requestSurpriseWithType:(NSString *)idId
                          Start:(requestStart)start
                            End:(requestEnd)end
                        Success:(requestSuccess)success
                        Failure:(requestFailure)failure;

@end
