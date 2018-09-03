@protocol AnalystsEventFilterVCDelegate <NSObject>
- (void)backStr:(NSString *)str;
@end
#import "ZBBasicViewController.h"
@interface ZBAnalystsEventFilterVC : ZBBasicViewController
@property (nonatomic, assign)id<AnalystsEventFilterVCDelegate> delegate;
@end
