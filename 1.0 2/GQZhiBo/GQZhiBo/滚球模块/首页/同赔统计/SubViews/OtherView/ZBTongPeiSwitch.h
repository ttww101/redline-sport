//
//  ZBTongPeiSwitch.h
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TongPeiSwitchDelegate<NSObject>
@optional
- (void)didSelectedIndex:(NSInteger )index;
@end
@interface ZBTongPeiSwitch : UIView
@property (nonatomic, weak) id<TongPeiSwitchDelegate> delegate;
- (void)setSelectedIndex:(NSInteger)index;
@end
