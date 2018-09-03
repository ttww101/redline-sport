#import <UIKit/UIKit.h>
@protocol TopContentViewDelegate <NSObject>
- (void)addAtention:(BOOL)attention;
@end
@interface ZBTopContentView : UIView
@property (nonatomic , strong) ZBUserModel *model;
@property (nonatomic, weak) id <TopContentViewDelegate> delegate;
@end
