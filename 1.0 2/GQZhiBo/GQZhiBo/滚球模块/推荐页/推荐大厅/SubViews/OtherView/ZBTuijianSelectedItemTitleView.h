//
//  ZBTuijianSelectedItemTitleView.h
//  GQapp
//
//  Created by WQ on 2017/8/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TuijianSelectedItemTitleViewDelegate<NSObject>
@optional
- (void)tapTuijianSelectedItemTitleViewAtindex:(NSInteger)index;
@end
@interface ZBTuijianSelectedItemTitleView : UIView
@property (nonatomic, weak) id<TuijianSelectedItemTitleViewDelegate> delegate;
- (void)updateSelectedIndexWithindex:(NSInteger)index WithTitle:(NSString *)title;
- (void)attentionBtnSelected:(BOOL)selected;
@end
