#import <UIKit/UIKit.h>
#import "ZBNavView.h"
typedef NS_ENUM(NSInteger,userType)
{
    userTypeMine = 0,
    userTypeOtherUser = 1,
};
typedef NS_ENUM(NSInteger,jingcaiListCellType) {
    jingcaiListCellTypeDating =0,
    jingcaiListCellTypeFenxi =1,
    jingcaiListCellTypeUserSingle =2,
    jingcaiListCellTypeMybuy =3,
    jingcaiListCellTypeUserAll =4,
};
@interface ZBBasicViewController : UIViewController<NavViewDelegate>
@property (nonatomic, strong) NSString *defaultFailure;
@end
