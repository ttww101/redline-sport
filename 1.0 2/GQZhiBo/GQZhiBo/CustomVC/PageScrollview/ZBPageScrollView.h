//
//  ZBPageScrollView.h
//  GQapp
//
//  Created by WQ on 2017/4/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBPageScrollView;
@protocol PageScrollViewDateSource <NSObject>
@required
- (UIView *)pageScrollView:(ZBPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index;
- (NSInteger)numberOfIndexInPageSrollView:(ZBPageScrollView *)pageScroll;
@end
@protocol PageScrollViewDelegate <NSObject>
@optional
- (void)scrollToPageIndex:(NSInteger)index;
@end

@interface ZBPageScrollView : ZBDCScrollVIew
@property (nonatomic, strong) id<PageScrollViewDateSource> dateSource;
@property (nonatomic, strong) id<PageScrollViewDelegate> pageDelegate;

//默认选中第几个
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)reloadData;
- (void)updateSelectedIndex:(NSInteger)index;
@end
