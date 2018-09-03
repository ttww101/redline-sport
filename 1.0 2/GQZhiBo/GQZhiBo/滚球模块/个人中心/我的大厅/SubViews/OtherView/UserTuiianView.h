//
//  UserTuiianView.h
//  GQapp
//
//  Created by WQ on 2017/4/20.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserTuiianViewDelegate<NSObject>
@optional
- (void)didTouchItemWithIndex:(NSInteger)index;
@end
@interface UserTuiianView : UIView
@property (nonatomic, strong) UserModel *model;
@property (nonatomic, weak) id<UserTuiianViewDelegate> delegate;
@property (nonatomic, strong) NSString *imageName;
@end
