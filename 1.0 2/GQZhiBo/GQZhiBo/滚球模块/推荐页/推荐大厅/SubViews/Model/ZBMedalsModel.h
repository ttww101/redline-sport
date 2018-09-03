//
//  ZBMedalsModel.h
//  GQapp
//
//  Created by WQ on 16/10/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//
//用户头衔
#import "ZBBasicModel.h"

/*
 name：勋章名称
 url:图片url
 number：获得勋章次数
 */

@interface ZBMedalsModel : ZBBasicModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger number;
@end
