//
//  ZBFriendsVC.h
//  GQapp
//
//  Created by WQ on 2017/4/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"

@interface ZBFriendsVC : ZBBasicViewController
@property (nonatomic, assign) NSInteger userId;
//0 关注 1 粉丝
@property (nonatomic, assign) NSInteger selectedIndex;
@end
