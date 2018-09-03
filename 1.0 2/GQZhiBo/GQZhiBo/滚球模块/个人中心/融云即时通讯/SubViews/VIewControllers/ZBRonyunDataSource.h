//
//  ZBRonyunDataSource.h
//  GQapp
//
//  Created by WQ on 16/9/27.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#define RongyunDataSource [ZBRonyunDataSource shareInstance]

@interface ZBRonyunDataSource : NSObject
//<
//RCIMUserInfoDataSource,
//RCIMGroupInfoDataSource,
//RCIMGroupUserInfoDataSource
//>



+ (ZBRonyunDataSource *)shareInstance;

///**
// *  同步自己的所属群组到融云服务器,修改群组信息后都需要调用同步
// */
//- (void)syncGroups;
//
///**
// *  获取群中的成员列表
// */
//- (void)getAllMembersOfGroup:(NSString *)groupId
//                      result:(void (^)(NSArray *userIdList))resultBlock;
//
///**
// *  从服务器同步好友列表
// */
//- (void)syncFriendList:(NSString *)userId
//              complete:(void (^)(NSMutableArray *friends))completion;
///*
// * 获取所有用户信息
// */
//- (NSArray *)getAllUserInfo:(void (^)())completion;
///*
// * 获取所有群组信息
// */
//- (NSArray *)getAllGroupInfo:(void (^)())completion;
///*
// * 获取所有好友信息
// */
//- (NSArray *)getAllFriends:(void (^)())completion;
//

@end
