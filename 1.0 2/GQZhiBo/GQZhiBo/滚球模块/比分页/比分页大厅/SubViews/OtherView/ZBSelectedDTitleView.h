#import <UIKit/UIKit.h>
#import "ZBHSTabBarContentView.h"
@protocol SelecterDTitleViewDelegate <NSObject>
- (void)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;
@end
@interface ZBSelectedDTitleView : UIView
@property (nonatomic, weak) id<SelecterDTitleViewDelegate>      delegate;
@end
