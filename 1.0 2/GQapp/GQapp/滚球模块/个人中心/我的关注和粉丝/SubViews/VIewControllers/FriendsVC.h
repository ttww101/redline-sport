//
//  FriendsVC.h
//  GQapp
//
//  Created by WQ on 2017/4/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicViewController.h"

@interface FriendsVC : BasicViewController
@property (nonatomic, assign) NSInteger userId;
//0 关注 1 粉丝
@property (nonatomic, assign) NSInteger selectedIndex;
@end
