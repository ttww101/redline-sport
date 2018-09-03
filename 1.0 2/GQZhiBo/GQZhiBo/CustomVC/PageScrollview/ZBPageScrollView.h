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
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)reloadData;
- (void)updateSelectedIndex:(NSInteger)index;
@end
