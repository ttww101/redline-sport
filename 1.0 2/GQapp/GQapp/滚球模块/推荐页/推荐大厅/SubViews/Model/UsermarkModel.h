//
//  UsermarkModel.h
//  GQapp
//
//  Created by WQ on 16/10/9.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface UsermarkModel : BasicModel
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) BOOL isvalid;
@end
