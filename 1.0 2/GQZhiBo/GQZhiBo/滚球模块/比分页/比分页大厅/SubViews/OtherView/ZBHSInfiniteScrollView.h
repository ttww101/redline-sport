//
//  ZBHSInfiniteScrollView.h
//  ZBHSInfiniteScrollView
//
//  Created by Marjoice on 22/08/2017.
//  Copyright © 2017 Zhuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum ScrollDirection {
    ScrollDirectionNext,
    ScrollDirectionPrev,
} ScrollDirection;

@class ZBHSInfiniteScrollView;

@protocol HSInfiniteScrollViewDelegate<NSObject>
@optional
- (void)updateView:(UIView *)view withProgress:(CGFloat)progress scrollDirection:(ScrollDirection)direction;
- (void)scrollView:(ZBHSInfiniteScrollView *)scrollView didScrollToIndex:(NSInteger)index;
@end

@protocol HSInfiniteScrollViewDataSource<NSObject>
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view;
- (NSInteger)numberOfViews;
- (NSInteger)numberOfVisibleViews;
@end

@interface ZBHSInfiniteScrollView: UIView
@property (nonatomic, readonly) NSInteger currentIndex;
@property (nonatomic, weak) id<HSInfiniteScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<HSInfiniteScrollViewDelegate> delegate;
@property (nonatomic) BOOL verticalScroll;
@property (nonatomic) BOOL scrollEnabled;
@property (nonatomic) BOOL pagingEnabled;
@property (nonatomic) BOOL bounces;
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) NSInteger maxScrollDistance;

- (void)reloadDataWithInitialIndex:(NSInteger)initialIndex;
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;
- (UIView *)viewAtIndex:(NSInteger)index;
- (NSArray *)allViews;
@end
