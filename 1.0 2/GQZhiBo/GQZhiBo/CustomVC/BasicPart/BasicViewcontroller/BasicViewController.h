//
//  BasicViewController.h
//  Wq
//
//  Created by WQ_h on 15/9/17.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavView.h"

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
@interface BasicViewController : UIViewController<NavViewDelegate>
@property (nonatomic, strong) NSString *defaultFailure;
@end
