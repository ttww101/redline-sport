//
//  DCTabBarController.h
//  DC_tabbar
//
//  Created by WQ_h on 15/12/21.
//  Copyright (c) 2015年 DC_H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTabBarController : UITabBarController<UITabBarControllerDelegate>
@property (nonatomic,assign)CGFloat height_myStateBar;
@property (nonatomic,assign)CGFloat height_myNavigationBar;
@property (nonatomic,assign)CGFloat height_myTabBar;
- (void)pushToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated;
- (void)presentToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)loadUreadNotificationNum;
- (void)loadUreadNotificationNumInMineView;

@end
