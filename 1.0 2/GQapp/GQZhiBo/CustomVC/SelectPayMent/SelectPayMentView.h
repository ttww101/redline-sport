//
//  SelectPayMentView.h
//  newGQapp
//
//  Created by genglei on 2018/4/16.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionView.h"

typedef NS_ENUM(NSUInteger, payMentType) {
    payMentTypeApplePurchase = 0,
    payMentTypeWx,
    payMentTypeAli,
    payMentTypeCoupon
};

typedef void(^payType)(payMentType type);

@interface SelectPayMentView : UIView

+ (instancetype)showPaymentInfo:(id)information
                        options:(NSArray *)option
                     animations:(BOOL)animation
                   selectOption:(payType)payType;


@end
