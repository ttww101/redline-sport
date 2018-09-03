#import <UIKit/UIKit.h>
@protocol UserTuiianViewDelegate<NSObject>
@optional
- (void)didTouchItemWithIndex:(NSInteger)index;
@end
@interface ZBUserTuiianView : UIView
@property (nonatomic, strong) ZBUserModel *model;
@property (nonatomic, weak) id<UserTuiianViewDelegate> delegate;
@property (nonatomic, strong) NSString *imageName;
@end
