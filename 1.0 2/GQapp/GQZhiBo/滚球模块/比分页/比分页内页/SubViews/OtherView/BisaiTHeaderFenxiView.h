//
//  BisaiTHeaderFenxiView.h
//  GQapp
//
//  Created by WQ on 2017/8/15.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TechtwoModel.h"
@interface BisaiTHeaderFenxiView : UIView
@property (nonatomic, strong) TechtwoModel *model;

// 0:home  1:guest;
@property (nonatomic, assign) NSInteger ishome;
@end
