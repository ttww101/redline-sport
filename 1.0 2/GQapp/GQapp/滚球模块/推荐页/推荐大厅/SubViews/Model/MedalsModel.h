//
//  MedalsModel.h
//  GQapp
//
//  Created by WQ on 16/10/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//
//用户头衔
#import "BasicModel.h"

/*
 name：勋章名称
 url:图片url
 number：获得勋章次数
 */

@interface MedalsModel : BasicModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger number;
@end
