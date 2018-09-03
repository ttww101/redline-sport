//
//  ZBViewPagerController.h
//  PHPHub
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZBBasicViewController.h"
typedef NS_ENUM(NSUInteger, ViewPagerOption) {
    ViewPagerOptionTabHeight,
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionCenterCurrentTab
};

typedef NS_ENUM(NSUInteger, ViewPagerComponent) {
    ViewPagerIndicator,
    ViewPagerTabsView,
    ViewPagerContent
};

@protocol ViewPagerDataSource;
@protocol ViewPagerDelegate;

@interface ZBViewPagerController :ZBBasicViewController  <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, weak) id<ViewPagerDataSource> dataSource;
@property (nonatomic, weak) id<ViewPagerDelegate> delegate;

@property UIPageViewController *pageViewController;

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index;

#pragma mark ViewPagerOptions

// 1.0: YES, 0.0: NO, defines if view should appear with the second or the first tab
// Defaults to NO
@property CGFloat startFromSecondTab;

// 1.0: YES, 0.0: NO, defines if tabs should be centered, with the given tabWidth
// Defaults to NO
@property CGFloat centerCurrentTab;

#pragma mark Colors
@property UIColor *contentViewBackgroundColor;

@property (nonatomic) BOOL manualLoadData;
@property (nonatomic) BOOL scrollingLocked;
#pragma mark ZBMethods
// Reload all tabs and contents
- (void)reloadData;

@end

#pragma mark dataSource
@protocol ViewPagerDataSource <NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForViewPager:(ZBViewPagerController *)viewPager;

@optional
// The content for any tab. Return a view controller and ViewPager will use its view to show as content
- (UIViewController *)viewPager:(ZBViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(ZBViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

@end

#pragma mark delegate
@protocol ViewPagerDelegate <NSObject>

@optional
// delegate object must implement this method if wants to be informed when a tab changes
- (void)viewPager:(ZBViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;
// Every time - reloadData called, ViewPager will ask its delegate for option values
// So you don't have to set options from ViewPager itself
- (CGFloat)viewPager:(ZBViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;

- (void)setSubViewScrollStatus:(BOOL)enabled;
@end
