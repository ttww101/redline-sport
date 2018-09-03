//
//  ZBDeatilHeaderView.h
//  newGQapp
//
//  Created by genglei on 2018/7/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBInfoModel.h"

@interface ZBDeatilHeaderView : UIView

@property (nonatomic , strong) InfoGroupModel *groupModel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
