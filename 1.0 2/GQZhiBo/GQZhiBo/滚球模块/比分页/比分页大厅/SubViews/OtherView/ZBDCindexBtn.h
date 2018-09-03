#import <UIKit/UIKit.h>
@protocol DCindexBtnDelegate<NSObject>
@optional
- (void)scrollToScale:(CGFloat)scaleY;
@end
@interface ZBDCindexBtn : UIView
@property (nonatomic, weak) id<DCindexBtnDelegate> delegate;
@property (nonatomic, assign) BOOL stopDelegateChangeBtnFrame;
- (void)updateScrollFrame:(CGFloat)frameY;
@end
