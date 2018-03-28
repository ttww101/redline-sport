//
//  BIfenSelectedSaishiModel.h
//  GQapp
//
//  Created by WQ_h on 16/8/26.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface BIfenSelectedSaishiModel : BasicModel
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger order;
//这个数据没有网络数据,是用来记录选中的状态的
@property (nonatomic, assign) BOOL isSelected;
@end
