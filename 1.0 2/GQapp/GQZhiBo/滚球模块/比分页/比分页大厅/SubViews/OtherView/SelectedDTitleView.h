//
//  SelectedDTitleView.h
//  GQapp
//
//  Created by Marjoice on 21/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSTabBarContentView.h"

@protocol SelecterDTitleViewDelegate <NSObject>

- (void)tabBarContentView:(HSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;

@end

@interface SelectedDTitleView : UIView
@property (nonatomic, weak) id<SelecterDTitleViewDelegate>      delegate;

@end
