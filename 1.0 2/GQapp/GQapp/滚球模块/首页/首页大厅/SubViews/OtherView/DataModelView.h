//
//  DataModelView.h
//  GQapp
//
//  Created by WQ on 2017/8/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DataModelViewDelegate<NSObject>
@optional
- (void)didSelectedDataModelViewIndex:(NSInteger)index;

@end
@interface DataModelView : UIView
@property (nonatomic, weak) id<DataModelViewDelegate> delegate;
@end
