//
//  ZBBisaiTHeaderFenxiView.h
//  GQapp
//
//  Created by WQ on 2017/8/15.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBTechtwoModel.h"
@interface ZBBisaiTHeaderFenxiView : UIView
@property (nonatomic, strong) ZBTechtwoModel *model;

// 0:home  1:guest;
@property (nonatomic, assign) NSInteger ishome;
@end
