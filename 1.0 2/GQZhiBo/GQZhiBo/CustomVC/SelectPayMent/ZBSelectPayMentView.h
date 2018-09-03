#import <UIKit/UIKit.h>
#import "ZBOptionView.h"
typedef NS_ENUM(NSUInteger, payMentType) {
    payMentTypeApplePurchase = 0,
    payMentTypeWx,
    payMentTypeAli,
    payMentTypeCoupon
};
typedef void(^payType)(payMentType type);
@interface ZBSelectPayMentView : UIView
+ (instancetype)showPaymentInfo:(id)information
                        options:(NSArray *)option
                     animations:(BOOL)animation
                   selectOption:(payType)payType;
@end
