//
//  DCTabBarController.h
//  DC_tabbar
//
//  Created by WQ_h on 15/12/21.
//  Copyright (c) 2015年 DC_H. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 控制器名字
 */

UIKIT_EXTERN NSString *const GQTableBarControllerName;

/**
 title
 */
UIKIT_EXTERN NSString *const GQTabBarItemTitle;

/**
 默认图片
 */
UIKIT_EXTERN NSString *const GQTabBarItemImage;

/**
 选中图片
 */
UIKIT_EXTERN NSString *const GQTabBarItemSelectedImage;

/**
 是否加载H5
 */
UIKIT_EXTERN NSString *const GQTabBarItemLoadH5;

UIKIT_EXTERN NSString *const GQTabBarItemWbebModel;

@interface DCTabBarController : UITabBarController<UITabBarControllerDelegate>
@property (nonatomic,assign)CGFloat height_myStateBar;
@property (nonatomic,assign)CGFloat height_myNavigationBar;
@property (nonatomic,assign)CGFloat height_myTabBar;
- (void)pushToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated;
- (void)presentToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)loadUreadNotificationNum;
- (void)loadUreadNotificationNumInMineView;

/**
 初始化
 
 @param itemArray tableBar  item Array
 @return <#return value description#>
 */
- (instancetype)initWithItemArray:(NSArray *)itemArray;

@end
