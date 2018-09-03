//
//  ZBTongpeiDTResultView.h
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBTongpeiDetailModel.h"
@interface ZBTongpeiDTResultView : UIView
//0： 全部   1：同赛事
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) ZBTongpeiDetailModel *model;
@end
