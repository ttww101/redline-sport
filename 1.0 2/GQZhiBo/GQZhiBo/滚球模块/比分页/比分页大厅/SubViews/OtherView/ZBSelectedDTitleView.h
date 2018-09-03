//
//  ZBSelectedDTitleView.h
//  GQapp
//
//  Created by Marjoice on 21/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBHSTabBarContentView.h"

@protocol SelecterDTitleViewDelegate <NSObject>

- (void)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;

@end

@interface ZBSelectedDTitleView : UIView
@property (nonatomic, weak) id<SelecterDTitleViewDelegate>      delegate;

@end
