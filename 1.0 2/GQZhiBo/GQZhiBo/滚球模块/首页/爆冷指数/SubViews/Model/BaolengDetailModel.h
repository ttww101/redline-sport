//
//  BaolengDetailModel.h
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"
#import "BaolengDTModel.h"
#import "BaolengMatchModel.h"
@interface BaolengDetailModel : BasicModel
@property (nonatomic, strong) BaolengDTModel *body;
@property (nonatomic, strong) NSArray *list;

@end
