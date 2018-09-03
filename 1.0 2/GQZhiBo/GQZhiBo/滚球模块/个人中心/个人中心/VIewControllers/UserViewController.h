//
//  UserViewController.h
//  GunQiuLive
//
//  Created by WQ_h on 16/3/23.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "ViewPagerController.h"
@interface UserViewController : BasicViewController
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger Number;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPic;

@end
