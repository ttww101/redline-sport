//
//  ZBBaolengDetailModel.h
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"
#import "ZBBaolengDTModel.h"
#import "ZBBaolengMatchModel.h"
@interface ZBBaolengDetailModel : ZBBasicModel
@property (nonatomic, strong) ZBBaolengDTModel *body;
@property (nonatomic, strong) NSArray *list;

@end
