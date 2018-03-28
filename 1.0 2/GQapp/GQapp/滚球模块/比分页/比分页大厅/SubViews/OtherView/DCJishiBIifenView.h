//
//  DCJishiBIifenView.h
//  GQapp
//
//  Created by WQ_h on 16/5/14.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsbfValue.h"
@interface DCJishiBIifenView : UIView
//是不是主队
@property (nonatomic, assign) BOOL ishome;
//是不是红牌
@property (nonatomic, assign) BOOL isRed;

@property (nonatomic, strong) JsbfValue *model;
@end
