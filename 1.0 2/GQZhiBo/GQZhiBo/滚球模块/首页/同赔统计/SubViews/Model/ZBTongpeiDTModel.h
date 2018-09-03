//
//  ZBTongpeiDTModel.h
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"
#import "ZBTongpeiDetailModel.h"
@interface ZBTongpeiDTModel : ZBBasicModel
@property (nonatomic, strong) ZBTongpeiDetailModel *same;
@property (nonatomic, strong) ZBTongpeiDetailModel *all;

@end
