//
//  ZBUserTuijianNumView.h
//  GQapp
//
//  Created by WQ on 2017/8/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBUserTongjiModel.h"
@interface ZBUserTuijianNumView : UIView
@property (nonatomic, strong) ZBUserTongjiModel *model;
@end


@interface NumViewUserTuijian : UIView
@property (nonatomic, strong) UIColor *scaleColor;
@property (nonatomic, assign) CGFloat scaleNum;

@end
