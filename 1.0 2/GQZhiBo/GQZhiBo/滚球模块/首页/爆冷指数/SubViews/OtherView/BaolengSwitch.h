//
//  BaolengSwitch.h
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaolengSwitchDelegate<NSObject>
@optional
- (void)didSelectedBaolengSwitchIndex:(NSInteger )index;
@end

@interface BaolengSwitch : UIView
@property (nonatomic, weak) id<BaolengSwitchDelegate> delegate;
- (void)setSelectedIndex:(NSInteger)index;

@end
