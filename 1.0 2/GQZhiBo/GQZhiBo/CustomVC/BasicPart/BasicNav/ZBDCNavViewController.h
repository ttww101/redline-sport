//
//  ZBDCNavViewController.h
//  GQapp
//
//  Created by WQ on 2016/12/23.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个protocol，实现此协议的类提供它自己的返回规则或者进行相应的个性化处理
@protocol NavigationControllerDelegate <NSObject>

@optional
- (BOOL) shouldPopOnBackButtonPress;

@end

@interface ZBDCNavViewController : UINavigationController

@end
