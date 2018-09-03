//
//  UniversalNetwork.h
//  GQapp
//
//  Created by WQ on 16/11/2.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
typedef void(^requestStart)(id requestOrignal);

typedef void (^UserInfo)(UserModel* user);
@interface UniversalNetwork : NSObject
+ (void)getUserModelWithUserId:(NSInteger)Idid WithUserModel:(UserInfo)user;

+ (void)getUserWithUserId:(NSInteger)Idid WithUserModel:(void(^)(UserModel* useInfo))user;

@end
