//
//  PlycPeilvView.h
//  GQapp
//
//  Created by WQ on 2017/9/27.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlycPeilvViewdelegate<NSObject>
@optional
- (void)didselePlycPeilvViewWithIndex:(NSInteger)index;
- (void)touchPlycPeilvViewBgView;
@end
@interface PlycPeilvView : UIView
@property (nonatomic,weak) id<PlycPeilvViewdelegate> delegate;
@end
