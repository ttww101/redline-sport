//
//  LiveQuizAlertView.h
//  newGQapp
//
//  Created by genglei on 2018/4/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelectAction)(id selectAction);

@interface LiveQuizAlertView : UIView

+ (instancetype)showPaymentInfo:(id)information
                     animations:(BOOL)animation
                   selectOption:(didSelectAction)selectAction;

@end
