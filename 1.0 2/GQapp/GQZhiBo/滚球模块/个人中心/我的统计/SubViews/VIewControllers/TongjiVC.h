//
//  TongjiVC.h
//  GQapp
//
//  Created by WQ on 2017/4/27.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicViewController.h"

@interface TongjiVC : BasicViewController
@property (nonatomic,assign) NSInteger tongjiType;
@property (nonatomic,assign) NSInteger Number;
@property (nonatomic, strong) UserModel *userModel;

@end
