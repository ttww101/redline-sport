#import <UIKit/UIKit.h>
@protocol PlycSelectedViewdelegate<NSObject>
@optional
- (void)didselectedPlycSelectedViewWithPlayIndex:(NSInteger)playIndex;
- (void)didselectedPlycSelectedViewWithTimeIndex:(NSInteger)TimeIndex;
- (void)touchPlycSelectedViewBGView;
@end
@interface ZBPlycSelectedView : UIView
@property (nonatomic, weak) id<PlycSelectedViewdelegate> delegate;
@end
