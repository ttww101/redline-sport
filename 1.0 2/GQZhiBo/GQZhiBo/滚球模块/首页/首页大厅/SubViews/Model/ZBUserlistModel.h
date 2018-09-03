//
//  ZBUserlistModel.h
//  GQapp
//
//  Created by WQ on 16/11/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBUserlistModel : ZBBasicModel
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSInteger newRecommendCount;
@property (nonatomic, copy) NSString *userintro;

@end
