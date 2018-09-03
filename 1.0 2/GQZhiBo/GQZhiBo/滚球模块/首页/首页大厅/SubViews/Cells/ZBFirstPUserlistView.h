#import <UIKit/UIKit.h>
#import "ZBUserlistModel.h"
@protocol FirstPUserlistViewDelegate <NSObject>
@optional
- (void)selectedUserWithId:(ZBUserlistModel *)user;
@end
@interface ZBFirstPUserlistView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<FirstPUserlistViewDelegate> delegate;
@end
