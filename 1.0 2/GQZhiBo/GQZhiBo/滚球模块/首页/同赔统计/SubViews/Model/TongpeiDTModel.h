//
//  TongpeiDTModel.h
//  GQapp
//
//  Created by WQ on 2017/8/10.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"
#import "TongpeiDetailModel.h"
@interface TongpeiDTModel : BasicModel
@property (nonatomic, strong) TongpeiDetailModel *same;
@property (nonatomic, strong) TongpeiDetailModel *all;

@end
