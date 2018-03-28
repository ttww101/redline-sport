//
//  DCindexBtn.h
//  GQapp
//
//  Created by WQ on 2017/7/5.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DCindexBtnDelegate<NSObject>
@optional
- (void)scrollToScale:(CGFloat)scaleY;
@end
@interface DCindexBtn : UIView
@property (nonatomic, weak) id<DCindexBtnDelegate> delegate;
@property (nonatomic, assign) BOOL stopDelegateChangeBtnFrame;

- (void)updateScrollFrame:(CGFloat)frameY;
@end
