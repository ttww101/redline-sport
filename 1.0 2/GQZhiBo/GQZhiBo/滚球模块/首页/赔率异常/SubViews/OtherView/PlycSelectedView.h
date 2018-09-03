//
//  PlycSelectedView.h
//  GQapp
//
//  Created by WQ on 2017/9/27.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlycSelectedViewdelegate<NSObject>
@optional
- (void)didselectedPlycSelectedViewWithPlayIndex:(NSInteger)playIndex;
- (void)didselectedPlycSelectedViewWithTimeIndex:(NSInteger)TimeIndex;
- (void)touchPlycSelectedViewBGView;
@end
@interface PlycSelectedView : UIView
@property (nonatomic, weak) id<PlycSelectedViewdelegate> delegate;
@end
