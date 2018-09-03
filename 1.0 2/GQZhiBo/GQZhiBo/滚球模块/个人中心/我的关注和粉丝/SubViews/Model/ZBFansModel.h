//
//  ZBFansModel.h
//  GQapp
//
//  Created by WQ_h on 16/3/31.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBFansModel : ZBBasicModel
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger recommend_count;
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger info_count;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) BOOL focused;
@end
