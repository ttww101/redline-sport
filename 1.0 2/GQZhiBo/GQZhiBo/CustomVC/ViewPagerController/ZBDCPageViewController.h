#import "ZBBasicViewController.h"
@class ZBDCPageViewController;
#pragma mark View Pager Delegate
@protocol  DCPageViewControllerDelegate <NSObject>
@optional
-(void)viewPagerViewController:(ZBDCPageViewController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController;
-(void)viewPagerViewController:(ZBDCPageViewController *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ZBViewController;
@end
#pragma mark View Pager DataSource
@protocol DCPageViewControllerDataSource <NSObject>
@required
-(NSInteger)numberViewControllersInViewPager:(ZBDCPageViewController *)viewPager;
-(UIViewController *)viewPager:(ZBDCPageViewController *)viewPager indexViewControllers:(NSInteger)index;
-(NSString *)viewPager:(ZBDCPageViewController *)viewPager titleWithIndexViewControllers:(NSInteger)index;
@optional
-(UIButton *)viewPager:(ZBDCPageViewController *)viewPager titleButtonStyle:(NSInteger)index;
-(CGFloat)heightForTitleViewPager:(ZBDCPageViewController *)viewPager;
-(UIView *)headerViewForInViewPager:(ZBDCPageViewController *)viewPager;
-(CGFloat)heightForHeaderViewPager:(ZBDCPageViewController *)viewPager;
@end
@interface ZBDCPageViewController : ZBBasicViewController
@property (nonatomic,weak) id<DCPageViewControllerDataSource> dataSource;
@property (nonatomic,weak) id<DCPageViewControllerDelegate> delegate;
-(void)reloadScrollPage;
@property(nonatomic,assign) NSInteger selectIndex;
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
