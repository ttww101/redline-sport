//
//  ZBSelectedEventView.h
//  GQapp
//
//  Created by WQ on 2017/5/5.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectedEventViewDelegate<NSObject>
@optional
- (void)didSelectedAtIndex:(NSInteger)index;
@end

@interface ZBSelectedEventView : UIView


@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat pageWidth;

@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSString *attentionNum;

@property (nonatomic, weak) id<SelectedEventViewDelegate> delegate;
- (void)updateSelectedIndex:(NSInteger)index;

@end
