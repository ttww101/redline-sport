#import <UIKit/UIKit.h>
@interface ZBWebviewProgressLine : UIView
@property (nonatomic,strong) UIColor  *lineColor;
-(void)startLoadingAnimation;
-(void)endLoadingAnimation;
@end
