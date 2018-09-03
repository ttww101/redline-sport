//
//  UserTuijianNumView.h
//  GQapp
//
//  Created by WQ on 2017/8/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTongjiModel.h"
@interface UserTuijianNumView : UIView
@property (nonatomic, strong) UserTongjiModel *model;
@end


@interface NumViewUserTuijian : UIView
@property (nonatomic, strong) UIColor *scaleColor;
@property (nonatomic, assign) CGFloat scaleNum;

@end
