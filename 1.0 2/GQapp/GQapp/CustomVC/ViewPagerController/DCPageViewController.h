//
//  DCPageViewController.h
//  CCAV5
//
//  Created by WQ on 2017/3/20.
//  Copyright © 2017年 Gunqiu. All rights reserved.
//

#import "BasicViewController.h"
@class DCPageViewController;

#pragma mark View Pager Delegate
@protocol  DCPageViewControllerDelegate <NSObject>
@optional
///返回当前显示的视图控制器
-(void)viewPagerViewController:(DCPageViewController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController;
///返回当前将要滑动的视图控制器
-(void)viewPagerViewController:(DCPageViewController *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ViewController;
@end

#pragma mark View Pager DataSource
@protocol DCPageViewControllerDataSource <NSObject>
@required
-(NSInteger)numberViewControllersInViewPager:(DCPageViewController *)viewPager;
-(UIViewController *)viewPager:(DCPageViewController *)viewPager indexViewControllers:(NSInteger)index;
-(NSString *)viewPager:(DCPageViewController *)viewPager titleWithIndexViewControllers:(NSInteger)index;
@optional
///设置控制器标题按钮的样式,不设置为默认
-(UIButton *)viewPager:(DCPageViewController *)viewPager titleButtonStyle:(NSInteger)index;
-(CGFloat)heightForTitleViewPager:(DCPageViewController *)viewPager;

///预留数据源
-(UIView *)headerViewForInViewPager:(DCPageViewController *)viewPager;
-(CGFloat)heightForHeaderViewPager:(DCPageViewController *)viewPager;
@end


@interface DCPageViewController : BasicViewController
@property (nonatomic,weak) id<DCPageViewControllerDataSource> dataSource;
@property (nonatomic,weak) id<DCPageViewControllerDelegate> delegate;
///刷新
-(void)reloadScrollPage;

///默认选中
@property(nonatomic,assign) NSInteger selectIndex;

///按钮下划线的高度 字体大小 默认颜色  选中颜色
@property (nonatomic,assign) CGFloat lineHeight;
@property (nonatomic,assign) CGFloat lineWidth;

@property (nonatomic,strong) UIFont *titleFont;
@property (nonatomic,strong) UIColor *defaultColor;
@property (nonatomic,strong) UIColor *chooseColor;

@end

#pragma mark 标题按钮
@interface XLBasePageTitleButton : UIButton

@property (nonatomic,assign) CGFloat buttonlineHeight;
@property (nonatomic,assign) CGFloat buttonlineWidth;

@end
