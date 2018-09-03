//
//  BaolengDTHeaderView.h
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaolengDTModel.h"
@interface BaolengDTHeaderView : UIView
@property (nonatomic, strong) BaolengDTModel *model;
//0： 全部   1：同赛事 2历史交锋
@property (nonatomic, assign) NSInteger type;

@end
